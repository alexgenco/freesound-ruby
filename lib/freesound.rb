require "freesound/version"
require "freesound/client"
require "freesound/resources/base"
require "freesound/resources/sound"
require "freesound/resources/user"

module Freesound
  class << self
    attr_writer :api_key

    def api_key
      @api_key || raise("Freesound requires an api_key")
    end
  end
end
