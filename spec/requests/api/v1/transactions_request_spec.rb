require 'rails_helper'

describe "Transactions API" do

  context "GET /transactions" do
    it "returns a list of transactions" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transaction1 = create(:transaction, invoice_id: invoice.id)
      transaction2 = create(:transaction, invoice_id: invoice.id)
      transaction3 = create(:transaction, invoice_id: invoice.id)

      get '/api/v1/transactions'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end

  context "GET /transactions/id" do
    it "returns a single transaction" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transaction = create(:transaction, invoice_id: invoice.id)

      get "/api/v1/transactions/#{transaction.id}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["id"]).to eq(transaction.id)
    end
  end

end
