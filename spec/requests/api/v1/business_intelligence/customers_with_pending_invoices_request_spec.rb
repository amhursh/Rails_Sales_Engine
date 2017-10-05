require 'rails_helper'

describe "Customers with Pending Invoices API" do
  it "sends customers that have pending invoices" do
    merchant = create(:merchant)
    
    customer1, customer2, customer3 = create_list(:customer, 3)
    
    invoice1, invoice2, invoice3 = create_list(:invoice, 3, merchant: merchant, customer: customer1)
    invoice4, invoice5, invoice6 = create_list(:invoice, 3, merchant: merchant, customer: customer2)
    invoice7, invoice8, invoice9 = create_list(:invoice, 3, merchant: merchant, customer: customer3)

    Invoice.all.each do |invoice|
      create(:transaction, invoice: invoice, result: "success")
    end

    invoice4.transactions.update(result: "failed")

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(customers.count).to eq 1
    expect(customers.first["id"]).to eq customer2.id
  end
end
