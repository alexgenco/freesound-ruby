require "integration/helper"

RSpec.describe "finding a sound" do
  let(:client) { Freesound::Client.new }

  context "that exists" do
    let(:sound) do
      client.sound(18763)
    end

    it "returns an object with sound attributes" do
      expect(sound.id).to be(18763)
      expect(sound.tags).to respond_to(:to_ary)
    end

    it "transforms dashified attributes to underscores" do
      expect(sound.previews.preview_hq_mp3).to respond_to(:to_str)
    end
  end

  context "that doesn't exist" do
    it "raises an exception" do
      expect {
        client.sound(123456789)
      }.to raise_error(/unexpected status code 404/i)
    end
  end
end
