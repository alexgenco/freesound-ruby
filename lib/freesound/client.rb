require "http"

module Freesound
  class Client
    def initialize(api_key: Freesound.api_key, api_url: Freesound.api_url)
      uri = URI.parse(api_url.to_s)
      url, @base_path = uri.merge("/"), uri.request_uri

      @http = HTTP
        .persistent(url)
        .auth("Token #{api_key}")
        .tap { |http| yield(http) if block_given? }
    end

    def text_search(q, **params)
      path = "#{@base_path}/search/text/"

      request(:get, path, params: {query: q, **params}) do |res|
        Response::Search.new(res, @http)
      end
    end

    def content_search(q, **params)
      path = "#{@base_path}/search/content/"

      request(:get, path, params: {query: q, **params}) do |res|
        Response::Search.new(res, @http)
      end
    end

    def content_search(q, **params)
      path = "#{@base_path}/search/content/"

      request(:get, path, params: {descriptors_filter: q, **params}) do |res|
        Response::Search.new(res, @http)
      end
    end

    def combined_search(**params)
      path = "#{@base_path}/search/combined/"

      request(:get, path, params: params) do |res|
        Response::CombinedSearch.new(res, @http)
      end
    end

    def sound(id, **params)
      path = "#{@base_path}/sounds/#{id}/"

      request(:get, path, params: params) do |res|
        Response::Sound.new(res, @http)
      end
    end

    def user(username, **params)
      path = "#{@base_path}/users/#{username}/"

      request(:get, path, params: params) do |res|
        Response::User.new(res, @http)
      end
    end

    def pack(id, **params)
      path = "#{@base_path}/packs/#{id}/"

      request(:get, path, params: params) do |res|
        Response::Pack.new(res, @http)
      end
    end

    def request(http_method, *args, **options)
      response = @http.public_send(http_method.to_s.downcase, *args, **options)

      block_given? ? yield(response) : response
    end

    module Response
      class Base < SimpleDelegator
        def initialize(response, http)
          super(response)
          @http = http
        end

        def data
          @data ||= parse
        end

        def follow_link(name, into_class, **params)
          if url = data[name.to_s]
            into_class.new(@http.get(url, params: params), @http)
          else
            nil
          end
        end
      end

      class Search < Base
        def next_page(**params)
          follow_link(:next, Search, **params)
        end

        def previous_page(**params)
          follow_link(:previous, Search, **params)
        end
      end

      class CombinedSearch < Base
        def more(**params)
          follow_link(:more, CombinedSearch, **params)
        end
      end

      class Sound < Base
        def similar_sounds(**params)
          follow_link(:similar_sounds, Search, **params)
        end
      end

      class User < Base
        def sounds(**params)
          follow_link(:sounds, Search, **params)
        end

        def packs(**params)
          follow_link(:packs, Search, **params)
        end
      end

      class Pack < Base
        def sounds(**params)
          follow_link(:sounds, Search, **params)
        end
      end
    end
  end
end
