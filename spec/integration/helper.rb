require "helper"
require "freesound"
require "vcr"

RSpec.configure do |config|
  config.before { Freesound.api_key = ENV.fetch("FREESOUND_KEY") }

  config.define_derived_metadata(file_path: %r(spec/integration)) do |metadata|
    metadata[:vcr] = true
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.filter_sensitive_data("<FREESOUND_KEY>") { ENV.fetch("FREESOUND_KEY") }
end
