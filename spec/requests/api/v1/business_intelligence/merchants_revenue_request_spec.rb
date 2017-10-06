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
    expect(revenue["total_revenue"]).to eq "20.0"
  end

  it "sends a given number of the top merchants by revenue" do
    merchant1, merchant2, merchant3 = create_list(:merchant, 3)
    customer = create(:customer)
    invoice1 = create(:invoice, customer: customer, merchant: merchant1)
    invoice2 = create(:invoice, customer: customer, merchant: merchant2)
    invoice3 = create(:invoice, customer: customer, merchant: merchant2)
    invoice4 = create(:invoice, customer: customer, merchant: merchant3)
    invoice5 = create(:invoice, customer: customer, merchant: merchant3)
    invoice6 = create(:invoice, customer: customer, merchant: merchant3)
    transact1 = create(:transaction, invoice: invoice1)
    transact2 = create(:transaction, invoice: invoice2)
    transact3 = create(:transaction, invoice: invoice3)
    transact4 = create(:transaction, invoice: invoice4)
    transact5 = create(:transaction, invoice: invoice5)
    transact6 = create(:transaction, invoice: invoice6)
    inv_item1 = create(:invoice_item, invoice: invoice1)
    inv_item2 = create(:invoice_item, invoice: invoice2)
    inv_item3 = create(:invoice_item, invoice: invoice3)
    inv_item4 = create(:invoice_item, invoice: invoice4)
    inv_item5 = create(:invoice_item, invoice: invoice5)
    inv_item6 = create(:invoice_item, invoice: invoice6)

    quantity = 2

    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq 2
    expect(merchants.first["id"]).to eq merchant3.id
    expect(merchants.last["id"]).to eq merchant2.id
  end

  it "sends the total revenue for a single merchant" do
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


    get "/api/v1/merchants/#{merchant1.id}/revenue"

    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue["revenue"]).to eq "10.0"

    get "/api/v1/merchants/#{merchant2.id}/revenue"

    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue["revenue"]).to eq "20.0"

  end

  it "sends the total revenue for a single merchant by date" do
    merchant1, merchant2 = create_list(:merchant, 2)
    customer = create(:customer)
    invoice1 = create(:invoice, customer: customer, merchant: merchant1, created_at: "2012-03-16 11:55:05")
    invoice2 = create(:invoice, customer: customer, merchant: merchant1, created_at: "2012-03-16 11:55:05")
    invoice3 = create(:invoice, customer: customer, merchant: merchant1, created_at: "2012-03-07 10:54:55")
    invoice4 = create(:invoice, customer: customer, merchant: merchant2, created_at: "2012-03-07 10:54:55")
    transact1 = create(:transaction, invoice: invoice1)
    transact2 = create(:transaction, invoice: invoice2)
    transact3 = create(:transaction, invoice: invoice3)
    transact3 = create(:transaction, invoice: invoice4)
    inv_item1 = create(:invoice_item, invoice: invoice1)
    inv_item2 = create(:invoice_item, invoice: invoice2)
    inv_item3 = create(:invoice_item, invoice: invoice3)
    inv_item3 = create(:invoice_item, invoice: invoice4)


    get "/api/v1/merchants/#{merchant1.id}/revenue?date=#{invoice1.created_at}"

    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue["revenue"]).to eq "20.0"

    get "/api/v1/merchants/#{merchant1.id}/revenue?date=#{invoice3.created_at}"

    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue["revenue"]).to eq "10.0"

    get "/api/v1/merchants/#{merchant2.id}/revenue?date=#{invoice1.created_at}"

    revenue = JSON.parse(response.body)

    expect(response).to be_success
    expect(revenue["revenue"]).to eq "0.0"

  end
end
