module Freesound
  class HTTPBasePath < HTTP::Feature
    HTTP::Options.register_feature(:base_path, self)

    def initialize(path)
      @path = path
    end

    def wrap_request(request)
      uri = request.uri
      uri.path = File.join(@path, uri.path)

      request
    end
  end
end
