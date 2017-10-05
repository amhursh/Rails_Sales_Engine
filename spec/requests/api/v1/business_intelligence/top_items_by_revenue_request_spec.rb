require 'rails_helper'

describe 'Items Revenue API' do
  it "returns a given quantity of the top items by revenue" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice)
    item1, item2, item3, item4, item5 = create_list(:item, 5, merchant: merchant)
    transaction = create(:transaction, invoice: invoice)

    create(:invoice_item, invoice: invoice, item: item1, unit_price: 1000)
    create(:invoice_item, invoice: invoice, item: item2, unit_price: 2000)
    create(:invoice_item, invoice: invoice, item: item3, unit_price: 3000)
    create(:invoice_item, invoice: invoice, item: item4, unit_price: 4000)
    create(:invoice_item, invoice: invoice, item: item5, unit_price: 1000)

    quantity = 2

    get "/api/v1/items/most_revenue?quantity=#{quantity}"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq 2
    expect(items.first["id"]).to eq item4.id
    expect(items.last["id"]).to eq item3.id
  end
end