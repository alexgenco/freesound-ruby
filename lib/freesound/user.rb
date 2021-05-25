module Freesound
  class User
    def initialize(http)
      @http = http
    end

    def get(username, **params)
      @http
        .get("/users/#{username}/", params: params)
        .parse(:json)
    end
  end
end
