require 'rails_helper'

describe "Customers Relationships API" do
  it "returns a collection of associated invoices" do
    customer = create(:customer)
    merchant = create(:merchant)
    create_list(:invoice, 13, customer: customer, merchant: merchant)

    get "/api/v1/customers/#{customer.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq 13
  end

  it "returns a collection of associated transactions" do
    customer = create(:customer)
    customer2 = create(:customer)
    merchant = create(:merchant)
    create_list(:invoice, 5, customer: customer, merchant: merchant)
    create_list(:invoice, 5, customer: customer2, merchant: merchant)

    customer.invoices.each do |invoice|
      2.times { create(:transaction, invoice: invoice) }
    end

    customer2.invoices.each do |invoice|
      2.times { create(:transaction, invoice: invoice) }
    end

    get "/api/v1/customers/#{customer.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq 10
  end
end
