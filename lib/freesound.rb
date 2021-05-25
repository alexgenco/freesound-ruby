require "freesound/version"
require "freesound/client"

module Freesound
  class << self
    attr_writer :api_key, :api_url

    def api_key
      @api_key || raise("Freesound requires an api_key")
    end

    def api_url
      @api_url ||= "https://freesound.org/apiv2"
    end
  end
end
