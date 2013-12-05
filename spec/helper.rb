$:.unshift File.expand_path("../lib", __FILE__)
require "rspec/autorun"
require "vcr"

RSpec.configure do |config|
  config.before { Freesound.api_key = ENV.fetch("FREESOUND_KEY") }
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock

  config.filter_sensitive_data("<FREESOUND_KEY>") { ENV.fetch("FREESOUND_KEY") }
end
