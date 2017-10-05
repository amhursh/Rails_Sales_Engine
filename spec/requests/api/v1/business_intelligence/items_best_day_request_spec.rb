require 'rails_helper'

describe "Items BI best_day API" do
  it "sends a list of the item's best day of sales" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    invoice1 = create(:invoice, customer: customer, merchant: merchant, created_at: "2012-03-22T03:55:09.000Z")
    invoice2 = create(:invoice, customer: customer, merchant: merchant, created_at: "2012-03-20T23:57:05.000Z")
    invoice3 = create(:invoice, customer: customer, merchant: merchant, created_at: "2012-03-20T23:57:05.000Z")
    create(:transaction, invoice: invoice1, result: 'success')
    create(:transaction, invoice: invoice2, result: 'success')
    create(:transaction, invoice: invoice3, result: 'failed')
    create(:invoice_item, invoice: invoice1, item: item, quantity: 10)
    create(:invoice_item, invoice: invoice2, item: item, quantity: 5)
    create(:invoice_item, invoice: invoice3, item: item, quantity: 20)


    get "/api/v1/items/#{item.id}/best_day"

    day = JSON.parse(response.body)

    expect(response).to be_success
    expect(day.to_datetime).to eq(invoice1.created_at.to_datetime)
  end


end
