module Freesound
  class Pack
    def initialize(http)
      @http = http
    end

    def get(id, **params)
      @http
        .get("/packs/#{id}/", params: params)
        .parse(:json)
    end
  end
end
