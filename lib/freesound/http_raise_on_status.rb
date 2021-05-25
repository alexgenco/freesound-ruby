module Freesound
  class StatusException < RuntimeError
    attr_reader :response

    def initialize(response)
      @response = response

      super("Unexpected status code #{response.status.code}")
    end
  end

  class RaiseOnStatus < HTTP::Feature
    HTTP::Options.register_feature(:raise_on_status, self)

    def wrap_response(response)
      if !response.status.success?
        raise StatusException.new(response.flush)
      end

      response
    end
  end
end
