require 'rails_helper'

describe "Merchants Revenue API" do
  it "sends the total revenue for a given date accross all merchants" do
    merchant1, merchant2 = create_list(:merchant, 2)
    customer = create(:customer)
    invoice1 = create(:invoice, customer: customer, merchant: merchant1)
    invoice2 = create(:invoice, customer: customer, merchant: merchant2)
    invoice3 = create(:invoice, customer: customer, merchant: merchant2)
    transact1 = create(:transaction, invoice: invoice1)
    transact2 = create(:transaction, invoice: invoice2)
    transact3 = create(:transaction, invoice: invoice3)
    inv_item1 = create(:invoice_item, invoice: invoice1)
    inv_item2 = create(:invoice_item, invoice: invoice2)
    inv_item3 = create(:invoice_item, invoice: invoice3)

    merchant2.invoices.each do |invoice|
      invoice.update(created_at: ("2012-03-16 11:55:05").to_datetime)
    end
    merchant1.invoices.each do |invoice|
      invoice.update(created_at: DateTime.yesterday)
    end

    date = "2012-03-16 11:55:05"

    get "/api/v1/merchants/revenue?date=#{date}"

    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue["total"]).to eq 2000
  end
end
