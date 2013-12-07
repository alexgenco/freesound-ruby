require "integration/helper"

describe "searching for a sound" do
  let(:client) { Freesound::Client.new }

  it "returns a list of sounds that match the query" do
    sounds = VCR.use_cassette(:search_csharp) do
      client.search("csharp")
    end

    expect(sounds.size).to be > 0
    expect(sounds.first.tags).to respond_to(:to_ary)
  end

  it "accepts additional query parameters" do
    sounds = VCR.use_cassette(:search_bass_3_results) do
      client.search("bass", p: 1, sounds_per_page: 2)
    end

    expect(sounds.size).to be(2)
    expect(sounds.first.tags).to respond_to(:to_ary)
  end

  it "ignores unrecognized query parameters" do
    expect {
      VCR.use_cassette(:search_bass_invalid_query) do
        client.search("bass", lol: :hi)
      end
    }.not_to raise_error
  end
end
