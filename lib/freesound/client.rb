require "freesound/deserializer"
require "freesound/http_base_path"
require "freesound/http_raise_on_status"
require "freesound/search"
require "freesound/sound"
require "freesound/user"
require "http"

module Freesound
  class ResourceNotFound < RuntimeError; end

  class Client
    def initialize(api_key: Freesound.api_key, api_url: Freesound.api_url)
      uri = URI.parse(api_url.to_s)
      url, base_path = uri.merge("/"), uri.request_uri

      @http = HTTP
        .persistent(url)
        .auth("Token #{api_key}")
        .use(base_path: HTTPBasePath.new(base_path))
        .use(raise_on_status: RaiseOnStatus.new)
    end

    def search(query, **params)
      Search.new(@http).text(query, **params)
    end

    def sound(id, **params)
      Sound.new(@http).get(id, **params)
    end

    def user(username, **params)
      User.new(@http).get(username, **params)
    end
  end
end
