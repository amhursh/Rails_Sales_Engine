require 'rails_helper'

describe "Customer BI favorite_merchant API" do
  it "sends the most purchased from merchant for customer" do
    customer = create(:customer)
    merchant1 = create(:merchant, name: 'merchant1')
    merchant2 = create(:merchant, name: 'merchant2')
    merchant3 = create(:merchant, name: 'merchant3')
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)
    item3 = create(:item, merchant: merchant3)
    invoice1 = create(:invoice, customer: customer, merchant: merchant1)
    invoice2 = create(:invoice, customer: customer, merchant: merchant2)
    invoice3 = create(:invoice, customer: customer, merchant: merchant3)
    create(:transaction, invoice: invoice1, result: 'success')
    create(:transaction, invoice: invoice2, result: 'success')
    create(:transaction, invoice: invoice3, result: 'failed')
    create(:invoice_item, invoice: invoice1, item: item1, quantity: 10)
    create(:invoice_item, invoice: invoice2, item: item2, quantity: 5)
    create(:invoice_item, invoice: invoice3, item: item3, quantity: 20)


    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["name"]).to eq(merchant1.name)
  end


end
