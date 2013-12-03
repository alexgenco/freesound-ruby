module Freesound
  class ResourceNotFound < RuntimeError; end

  class Client < Struct.new(:api_key)
    def sound(id)
      begin
        Resources::Sound.find(id, params: query_params)
      rescue ActiveResource::BadRequest
        raise ResourceNotFound, "Sound with id #{id} not found"
      end
    end

    def search(query)
      Resources::Sound.get("search/", query_params(q: query))
    end

    private

    def query_params(additional={})
      {api_key: api_key}.merge(additional)
    end
  end
end
