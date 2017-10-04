require 'rails_helper'

describe "Items API" do
  it "sends a list of all items" do
    merchant = create(:merchant)

    item1, item2, item3 = create_list(:item, 3, merchant: merchant)

    get '/api/v1/items'

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq 3
  end

  it "can get one item by its id" do
    merchant = create(:merchant)

    item1, item2, item3 = create_list(:item, 3, merchant: merchant)

    get "/api/v1/items/#{item3.id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq item3.id
    expect(item["name"]).to eq item3.name
    expect(item["description"]).to eq item3.description
    expect(item["merchant_id"]).to eq merchant.id
    expect(item["unit_price"]).to eq (item3.unit_price / 100.0).to_s
  end

  it "can find individual items by params" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)

    item1 = create(:item,
                   name: "Aaron",
                   description: "something",
                   unit_price: 3000,
                   merchant_id: merchant.id,
                   )
    item2 = create(:item,
                   name: "JP",
                   description: "coolbeans",
                   unit_price: 5000,
                   merchant_id: merchant2.id,
                   )
    item3 = create(:item,
                   name: "This guy",
                   description: "whatthehell",
                   unit_price: 9000,
                   merchant_id: merchant.id,
                   )

    get "/api/v1/items/find?id=#{item1.id}"

    item = JSON.parse(response.body)

    expect(item["id"]).to eq item1.id

    get "/api/v1/items/find?name=#{item2.name}"

    item = JSON.parse(response.body)

    expect(item["name"]).to eq item2.name

    get "/api/v1/items/find?description=#{item3.description}"

    item = JSON.parse(response.body)

    expect(item["description"]).to eq item3.description

    get "/api/v1/items/find?merchant_id=#{item2.merchant_id}"

    item = JSON.parse(response.body)

    expect(item["id"]).to eq item2.id
  end

  it "can find all invoices by params" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)

    item1 = create(:item,
                   name: "Aaron",
                   description: "something",
                   unit_price: 3000,
                   merchant_id: merchant.id,
                   )
    item2 = create(:item,
                   name: "JP",
                   description: "coolbeans",
                   unit_price: 5000,
                   merchant_id: merchant2.id,
                   )
    item3 = create(:item,
                   name: "Aaron",
                   description: "whatthehell",
                   unit_price: 9000,
                   merchant_id: merchant.id,
                   )

    get "/api/v1/items/find_all?merchant_id=#{merchant.id}"

    items = JSON.parse(response.body)

    expect(items.count).to eq 2

    get "/api/v1/items/find_all?name=#{item1.name}"

    items = JSON.parse(response.body)

    expect(items.count).to eq 2

    get "/api/v1/items/find_all?name=#{item2.name}"

    items = JSON.parse(response.body)

    expect(items.count).to eq 1
  end

  it "can find random item" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)

    item1 = create(:item,
                   name: "Aaron",
                   description: "something",
                   unit_price: 3000,
                   merchant_id: merchant.id,
                   )
    item2 = create(:item,
                   name: "JP",
                   description: "coolbeans",
                   unit_price: 5000,
                   merchant_id: merchant2.id,
                   )
    item3 = create(:item,
                   name: "Aaron",
                   description: "whatthehell",
                   unit_price: 9000,
                   merchant_id: merchant.id,
                   )

    get "/api/v1/items/random"

    item = JSON.parse(response.body)

    expect(Item.pluck(:id)).to include(item["id"])
  end
end