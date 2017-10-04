require 'rails_helper'

describe "Invoices Relationships API" do
  context "GET /api/v1/invoices/:id/transactions" do
    it "returns a collection of associated transactions" do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice1, invoice2 = create_list(:invoice, 2, customer: customer, merchant: merchant)
      create_list(:transaction, 2, invoice_id: invoice1.id)
      create(:transaction, invoice_id: invoice2.id)

      get "/api/v1/invoices/#{invoice1.id}/transactions"
      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(2)

      get "/api/v1/invoices/#{invoice2.id}/transactions"
      transactions = JSON.parse(response.body)

      expect(response).to be_success
      expect(transactions.count).to eq(1)
    end
  end

  context "GET /api/v1/invoices/:id/invoice_items" do
    it "returns a collection of associated invoice items" do
      customer = create(:customer)
      merchant = create(:merchant)
      item1, item2 = create_list(:item, 2, merchant: merchant)
      invoice1, invoice2 = create_list(:invoice, 2, customer: customer, merchant: merchant)
      invoice_item1, invoice_item2 = create_list(:invoice_item, 2, item_id: item1.id, invoice_id: invoice1.id)
      invoice_item3 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)


      get "/api/v1/invoices/#{invoice1.id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(2)

      get "/api/v1/invoices/#{invoice2.id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(1)
    end
  end

  context "GET /api/v1/invoices/:id/items" do
    it "returns a collection of associated items" do
      customer = create(:customer)
      merchant = create(:merchant)
      item1, item2 = create_list(:item, 2, merchant: merchant)
      invoice1, invoice2 = create_list(:invoice, 2, customer: customer, merchant: merchant)
      invoice_item1, invoice_item2 = create_list(:invoice_item, 2, item_id: item1.id, invoice_id: invoice1.id)
      invoice_item3 = create(:invoice_item, item_id: item2.id, invoice_id: invoice2.id)


      get "/api/v1/invoices/#{invoice1.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(2)

      get "/api/v1/invoices/#{invoice2.id}/items"

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(1)
    end
  end

  context "GET /api/v1/invoices/:id/customer" do
    it "returns the associated customer" do
      customer1, customer2 = create_list(:customer, 2)
      merchant = create(:merchant)
      invoice1 = create(:invoice, customer: customer1, merchant: merchant)
      invoice2 = create(:invoice, customer: customer2, merchant: merchant)

      get "/api/v1/invoices/#{invoice1.id}/customer"
      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(customer1.id)

      get "/api/v1/invoices/#{invoice2.id}/customer"
      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["id"]).to eq(customer2.id)
    end
  end

  context "GET /api/v1/invoices/:id/merchant" do
    it "returns the associated merchant" do
      customer = create(:customer)
      merchant1, merchant2 = create_list(:merchant, 2)
      invoice1 = create(:invoice, customer: customer, merchant: merchant1)
      invoice2 = create(:invoice, customer: customer, merchant: merchant2)

      get "/api/v1/invoices/#{invoice1.id}/merchant"
      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(merchant1.id)

      get "/api/v1/invoices/#{invoice2.id}/merchant"
      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(merchant2.id)
    end
  end

end
