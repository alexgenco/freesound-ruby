RSpec.describe Freesound::Client, :vcr do
  let(:client) { described_class.new }

  specify "#text_search" do
    response_0 = client.content_search(
      "bass",
      filter: "duration:[0.5 TO 100.0]",
      page: 1,
      page_size: 2,
    )

    expect(response_0.status).to eq(200)
    expect(response_0.data["results"].size).to eq(2)
    expect(response_0.data["results"].first["tags"]).to respond_to(:to_ary)

    response_1 = response_0.next_page

    expect(response_1.status).to eq(200)
    expect(response_1.data["results"].size).to eq(2)
    expect(response_1.data["results"].first["tags"]).to respond_to(:to_ary)

    response_2 = response_1.previous_page

    expect(response_2.data).to eq(response_0.data)
  end

  specify "#content_search" do
    response_0 = client.content_search(
      "lowlevel.pitch.var:[* TO 20]",
      target: "lowlevel.pitch.mean:440",
      page: 1,
      page_size: 2,
    )

    expect(response_0.status).to eq(200)
    expect(response_0.data["results"].size).to eq(2)
    expect(response_0.data["results"].first["tags"]).to respond_to(:to_ary)

    response_1 = response_0.next_page

    expect(response_1.status).to eq(200)
    expect(response_1.data["results"].size).to eq(2)
    expect(response_1.data["results"].first["tags"]).to respond_to(:to_ary)

    response_2 = response_1.previous_page

    expect(response_2.data).to eq(response_0.data)
  end

  specify "#combined_search" do
    response_0 = client.combined_search(
      filter: "bass",
      target: "lowlevel.pitch.mean:220 lowlevel.pitch.var:100",
      page: 1,
      page_size: 2,
    )

    expect(response_0.status).to eq(200)
    expect(response_0.data["results"].size).to eq(2)
    expect(response_0.data["results"].first["distance_to_target"]).to be_a(Float)

    response_1 = response_0.more

    expect(response_1.status).to eq(200)
    expect(response_1.data["results"].size).to eq(2)
    expect(response_1.data["results"].first["distance_to_target"]).to be_a(Float)
  end

  specify "#sound" do
    response = client.sound(18763)

    expect(response.status).to eq(200)
    expect(response.data["id"]).to eq(18763)
    expect(response.data["tags"]).to respond_to(:to_ary)

    similar = response.similar_sounds

    expect(similar.status).to eq(200)
    expect(similar.data["count"]).to be > 0
  end

  specify "#user" do
    response = client.user("alexgenco")

    expect(response.status).to eq(200)
    expect(response.data["username"]).to eq("alexgenco")
    expect(response.data["url"]).to match(/\/people\/alexgenco/)

    sounds = response.sounds

    expect(sounds.status).to eq(200)
    expect(sounds.data["count"]).to be >= 0

    packs = response.packs

    expect(packs.status).to eq(200)
    expect(packs.data["count"]).to be >= 0
  end

  specify "#pack" do
    response = client.pack(5107)

    expect(response.status).to eq(200)
    expect(response.data["url"]).to match(/packs/)

    sounds = response.sounds

    expect(sounds.status).to eq(200)
    expect(sounds.data["count"]).to be >= 0
  end
end
