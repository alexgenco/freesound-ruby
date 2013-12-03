require "freesound/version"
require "freesound/client"
require "freesound/resources/sound"

module Freesound
  def self.api_key
    ENV["FREESOUND_KEY"] || raise("Missing $FREESOUND_KEY")
  end
end
