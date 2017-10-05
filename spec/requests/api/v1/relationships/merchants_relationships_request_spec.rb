require 'rails_helper'

describe "Merchant Relationships API" do
  it "returns a collection of items associated with a merchant" do
    merchant = create(:merchant)
    create_list(:item, 10, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq 10
  end
end