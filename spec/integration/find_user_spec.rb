require "integration/helper"
require "securerandom"

RSpec.describe "finding a user" do
  let(:client) { Freesound::Client.new }

  context "that exists" do
    let(:user) { client.user("alexgenco") }

    it "returns an object with user attributes" do
      expect(user.username).to eq("alexgenco")
      expect(user.url).to match(/\/people\/alexgenco/)
    end
  end

  context "that doesn't exist" do
    it "raises an exception" do
      expect {
        client.user("891c05b5-9bf5-4bcc-a906-d0a8a78b8ed8")
      }.to raise_error(/unexpected status code 404/i)
    end
  end
end
