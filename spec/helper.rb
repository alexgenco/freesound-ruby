$:.unshift File.expand_path("../lib", __FILE__)
require 'rspec/autorun'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.allow_http_connections_when_no_cassette = true
  c.hook_into :webmock
end
