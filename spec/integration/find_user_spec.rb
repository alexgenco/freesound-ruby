require "integration/helper"

describe "finding a user" do
  let(:client) { Freesound::Client.new }

  context "that exists" do
    let(:user) do
      VCR.use_cassette(:user_alexgenco) do
        client.user("AlexGenco")
      end
    end

    it "returns an object with user attributes" do
      expect(user.username).to eq("alexgenco")
      expect(user.ref).to match(/\/people\/alexgenco/)
    end
  end

  context "that doesn't exist" do
    it "raises an exception" do
      expect {
        VCR.use_cassette(:user_unknown) do
          client.user("LOLWHOAMI__123")
        end
      }.to raise_error(Freesound::ResourceNotFound,
                       /user with username 'LOLWHOAMI__123'/i)
    end
  end
end
