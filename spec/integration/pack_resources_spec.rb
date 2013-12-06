require "helper"
require "freesound"

describe "a pack with resources" do
  let(:client) { Freesound::Client.new }

  let(:pack) do
    VCR.use_cassette(:pack_5107) do
      client.pack(5107)
    end
  end

  it "has many sounds" do
    VCR.use_cassette(:pack_5107_sounds) do
      expect(pack.sounds).to respond_to(:to_ary)
      expect(pack.sounds.first).to respond_to(:duration)
    end
  end
end
