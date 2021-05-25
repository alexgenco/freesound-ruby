module Freesound
  class Search
    def initialize(http)
      @http = http
    end

    def text(query, **params)
      @http
        .get("/search/text/", params: {query: query, **params})
        .parse(:json)
    end
  end
end
