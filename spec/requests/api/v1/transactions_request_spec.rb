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

  context "GET /transactions/find?params" do
    it "returns a single transaction from params" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transaction1 = create(:transaction, invoice_id: invoice1.id)
      transaction2 = create(:transaction, invoice_id: invoice2.id)


      get "/api/v1/transactions/find?id=#{transaction1.id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(transaction1.id)

      get "/api/v1/transactions/find?invoice_id=#{transaction2.invoice_id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(transaction2.id)
    end
  end

  context "GET /transactions/find_all?params" do
    it "returns a multiple transactions from params" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transaction1 = create(:transaction, invoice_id: invoice1.id)
      transaction2 = create(:transaction, invoice_id: invoice2.id)
      transaction3 = create(:transaction, invoice_id: invoice2.id)


      get "/api/v1/transactions/find_all?id=#{transaction1.id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction.first["id"]).to eq(transaction1.id)

      get "/api/v1/transactions/find_all?invoice_id=#{transaction2.invoice_id}"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction.count).to eq(2)

      expect(transaction.first["id"]).to eq(transaction2.id)
      expect(transaction.second["id"]).to eq(transaction3.id)
    end
  end

  context "GET /transactions/random" do
    it "returns a random transaction" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      transaction1 = create(:transaction, invoice_id: invoice1.id)
      transaction2 = create(:transaction, invoice_id: invoice2.id)


      get "/api/v1/transactions/random"

      transaction = JSON.parse(response.body)

      expect(response).to be_success
      expect(transaction["id"]).to eq(transaction1.id).or eq(transaction2.id)
    end
  end


end
