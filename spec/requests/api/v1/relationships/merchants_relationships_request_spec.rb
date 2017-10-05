require 'rails_helper'

describe "Merchant Relationships API" do
  it "returns a collection of items associated with a merchant" do
    merchant = create(:merchant)
    create_list(:item, 10, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq 10
  end

  it "returns a collection of invoices associated with a merchant" do
    merchant = create(:merchant)
    customer = create(:customer)
    create_list(:invoice, 10, customer: customer, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq 10
  end
end