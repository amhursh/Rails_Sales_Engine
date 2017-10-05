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

# it "sends a given number of the top merchants by revenue" do
#     merchant1, merchant2, merchant3 = create_list(:merchant, 3)
#     customer = create(:customer)
#     invoice1 = create(:invoice, customer: customer, merchant: merchant1)
#     invoice2 = create(:invoice, customer: customer, merchant: merchant2)
#     invoice3 = create(:invoice, customer: customer, merchant: merchant2)
#     invoice4 = create(:invoice, customer: customer, merchant: merchant3)
#     invoice5 = create(:invoice, customer: customer, merchant: merchant3)
#     invoice6 = create(:invoice, customer: customer, merchant: merchant3)
#     transact1 = create(:transaction, invoice: invoice1)
#     transact2 = create(:transaction, invoice: invoice2)
#     transact3 = create(:transaction, invoice: invoice3)
#     transact4 = create(:transaction, invoice: invoice4)
#     transact5 = create(:transaction, invoice: invoice5)
#     transact6 = create(:transaction, invoice: invoice6)
#     inv_item1 = create(:invoice_item, invoice: invoice1)
#     inv_item2 = create(:invoice_item, invoice: invoice2)
#     inv_item3 = create(:invoice_item, invoice: invoice3)
#     inv_item4 = create(:invoice_item, invoice: invoice4)
#     inv_item5 = create(:invoice_item, invoice: invoice5)
#     inv_item6 = create(:invoice_item, invoice: invoice6)

#     quantity = 2

#     get "/api/v1/merchants/most_revenue?quantity=#{quantity}"

#     merchants = JSON.parse(response.body)

#     expect(response).to be_success
#     expect(merchants.count).to eq 2
#     expect(merchants.first["id"]).to eq merchant3.id
#     expect(merchants.last["id"]).to eq merchant2.id
#   end