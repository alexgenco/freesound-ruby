require "integration/helper"

describe "finding a pack" do
  let(:client) { Freesound::Client.new }

  context "that exists" do
    let(:pack) do
      VCR.use_cassette(:pack_5107) do
        client.pack(5107)
      end
    end

    it "returns an object with pack attributes" do
      expect(pack.ref).to match(/packs/)
    end
  end

  context "that doesn't exist" do
    it "raises an exception" do
      expect {
        VCR.use_cassette(:pack_unknown) do
          client.pack(123456789)
        end
      }.to raise_error(Freesound::ResourceNotFound,
                       /pack with id 123456789/i)
    end
  end
end
