module Freesound
  class ResourceNotFound < RuntimeError; end

  class Client
    def sound(id)
      begin
        Resources::Sound.find(id, params: query_params)
      rescue ActiveResource::BadRequest
        raise ResourceNotFound, "Sound with id #{id} not found"
      end
    end

    def user(username)
      begin
        Resources::User.find(username, params: query_params)
      rescue ActiveResource::BadRequest
        raise ResourceNotFound, "User with username '#{username}' not found"
      end
    end

    def pack(id)
      begin
        Resources::Pack.find(id, params: query_params)
      rescue ActiveResource::BadRequest
        raise ResourceNotFound, "Pack with id #{id} not found"
      end
    end

    def search(query)
      Resources::Sound.get(:search, query_params(q: query))
    end

    private

    def query_params(additional={})
      {api_key: Freesound.api_key}.merge(additional)
    end
  end
end
