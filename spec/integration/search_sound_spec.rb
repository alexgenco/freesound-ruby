require "integration/helper"

RSpec.describe "searching for a sound" do
  let(:client) { Freesound::Client.new }

  it "returns a list of sounds that match the query" do
    search = client.search("csharp")

    expect(search.results.size).to be > 0
    expect(search.results.first.tags).to respond_to(:to_ary)
  end

  it "accepts additional query parameters" do
    search = client.search("bass", page: 1, page_size: 2)

    expect(search.results.size).to be(2)
    expect(search.results.first.tags).to respond_to(:to_ary)
  end
end
