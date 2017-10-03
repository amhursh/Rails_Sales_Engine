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
end