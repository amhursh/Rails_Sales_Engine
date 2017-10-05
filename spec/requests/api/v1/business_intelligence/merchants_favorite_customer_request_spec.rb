require 'rails_helper'

describe 'Merchants Favorite Customer API' do
  it 'sends customer who has conducted highest number of successful transactions' do
    merchant = create(:merchant)
    
    customer1, customer2, customer3 = create_list(:customer, 3)
    
    invoice1, invoice2, invoice3 = create_list(:invoice, 3, merchant: merchant, customer: customer1)
    invoice4, invoice5, invoice6 = create_list(:invoice, 3, merchant: merchant, customer: customer2)
    invoice7, invoice8, invoice9 = create_list(:invoice, 3, merchant: merchant, customer: customer3)

    Invoice.all.each do |invoice|
      create(:transaction, invoice: invoice, result: "success")
    end

    invoice1.transactions.first.update(result: "failed")
    invoice2.transactions.first.update(result: "failed")
    invoice7.transactions.first.update(result: "failed")

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    fav_cust = JSON.parse(response.body)

    expect(response).to be_success
    expect(fav_cust["id"]).to eq customer2.id
  end
end