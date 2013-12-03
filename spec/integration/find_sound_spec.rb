require 'helper'
require 'freesound'

describe "finding a sound" do
  let(:api_key) { ENV.fetch("FREESOUND_KEY") }
  let(:client)  { Freesound::Client.new(api_key) }

  it "returns a sound object" do
    found = client.sounds.find(18763)

    expect(found.id).to be(18763)
    expect(found.ref).to match(/\/sounds\/18763/)
    expect(found.tags).to respond_to(:each)
  end
end
