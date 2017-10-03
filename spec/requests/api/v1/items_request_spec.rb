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
    expect(item["unit_price"]).to eq item3.unit_price
  end
end