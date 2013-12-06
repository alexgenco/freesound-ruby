require "active_resource"
require "uri"

require "freesound/version"
require "freesound/client"
require "freesound/collections"
require "freesound/resources"

module Freesound
  class << self
    attr_writer :api_key

    def api_key
      @api_key || raise("Freesound requires an api_key")
    end
  end
end
