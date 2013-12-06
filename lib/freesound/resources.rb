module Freesound
  module Resources
    class Base < ActiveResource::Base
      self.site = "http://www.freesound.org/api"
      self.include_format_in_path = false

      # The Freesound API requires URLs to have a trailing slash
      # before their query parameters, otherwise the request will
      # result in a redirect.
      #
      # These are hacks to construct the URLs correctly because
      # ActiveResource does not append a trailing slash.
      class << self
        def element_path(id, *args)
          super("#{id}/", *args)
        end

        def get(path, *args)
          super("#{path}/", *args)
        end
      end

      private

      def query_params(additional={})
        {api_key: Freesound.api_key}.merge(additional)
      end
    end

    class User < Base
      self.collection_name = "people"

      def id
        username
      end

      def sounds(refresh=false)
        @sounds = nil if refresh

        @sounds ||= begin
          path = URI.parse(super).path
          Sound.find(:all, from: path, params: query_params)
        end
      end

      def packs(refresh=false)
        @packs = nil if refresh

        @packs ||= begin
          path = URI.parse(super).path
          Pack.find(:all, from: path, params: query_params)
        end
      end
    end

    class Sound < Base
      self.collection_parser = "Freesound::Collections::Sounds"
    end

    class Pack < Base
      self.collection_parser = "Freesound::Collections::Packs"

      def sounds(refresh=false)
        @sounds = nil if refresh

        @sounds ||= begin
          path = URI.parse(super).path
          Sound.find(:all, from: path, params: query_params)
        end
      end
    end
  end
end
