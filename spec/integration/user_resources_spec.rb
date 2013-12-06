require "integration/helper"

describe "a user with resources" do
  let(:client) { Freesound::Client.new }

  let(:user) do
    VCR.use_cassette(:user_jovica) do
      client.user("Jovica")
    end
  end

  it "has many sounds" do
    VCR.use_cassette(:jovica_sounds) do
      expect(user.sounds).to respond_to(:to_ary)
      expect(user.sounds.first).to respond_to(:duration)
    end
  end

  it "has many packs" do
    VCR.use_cassette(:jovica_packs) do
      expect(user.packs).to respond_to(:to_ary)
      expect(user.packs.first.ref).to match(/packs/)
    end
  end
end
