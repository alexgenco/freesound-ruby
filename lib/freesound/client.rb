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

    private

    def query_params
      {api_key: api_key}
    end
  end
end
