require "helper"
require "freesound"

describe "searching for a sound" do
  let(:client) { Freesound::Client.new }

  it "returns a list of sounds that match the query" do
    sounds = VCR.use_cassette(:search_csharp) do
      client.search("csharp")
    end
    expect(sounds.size).to be > 0
  end
end
