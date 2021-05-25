require "integration/helper"

RSpec.describe "finding a pack" do
  let(:client) { Freesound::Client.new }

  context "that exists" do
    let(:pack) { client.pack(5107) }

    it "returns an object with pack attributes" do
      expect(pack.url).to match(/packs/)
    end
  end

  context "that doesn't exist" do
    it "raises an exception" do
      expect {
        client.pack(123456789)
      }.to raise_error(Freesound::StatusException, /unexpected status code 404/i)
    end
  end
end
