module Freesound
  class Sound
    def initialize(http)
      @http = http
    end

    def get(id, **params)
      @http
        .get("/sounds/#{id}/", params: params)
        .parse(:json)
    end
  end
end
