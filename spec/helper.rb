$:.unshift File.expand_path("../lib", __FILE__)
require 'rspec/autorun'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end
