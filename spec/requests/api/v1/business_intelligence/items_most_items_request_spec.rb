require 'rails_helper'

describe "Items BI most_items API" do
  it "sends a list of the most sold items" do
    customer = create(:customer)
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    item3 = create(:item, merchant: merchant)
    invoice1 = create(:invoice, customer: customer, merchant: merchant)
    invoice2 = create(:invoice, customer: customer, merchant: merchant)
    invoice3 = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, invoice: invoice1, result: 'success')
    create(:transaction, invoice: invoice2, result: 'success')
    create(:transaction, invoice: invoice3, result: 'failed')
    create(:invoice_item, invoice: invoice1, item: item1, quantity: 10)
    create(:invoice_item, invoice: invoice2, item: item2, quantity: 5)
    create(:invoice_item, invoice: invoice3, item: item3, quantity: 20)


    get "/api/v1/items/most_items?quantity=3"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(2)
    expect(items.first["id"]).to eq(item1.id)
    expect(items.second["id"]).to eq(item2.id)
  end


end
