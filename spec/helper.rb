require "freesound"
require "pry"
require "pry-byebug"
require "vcr"

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true
  config.order = :random
  Kernel.srand config.seed

  config.before do
    Freesound.api_key = ENV.fetch("FREESOUND_KEY")
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.filter_sensitive_data("<FREESOUND_KEY>") { ENV.fetch("FREESOUND_KEY") }
end
