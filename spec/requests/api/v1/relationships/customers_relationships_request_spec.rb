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
end
