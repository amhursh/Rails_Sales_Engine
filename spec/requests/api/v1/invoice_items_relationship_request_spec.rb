require 'rails_helper'

describe "Invoice Items Relationships API" do

  context "GET /api/v1/invoice_items/:id/invoice" do
    it "returns the associated invoice" do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item)
      invoice1, invoice2 = create_list(:invoice, 2, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item: item)
      invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item: item)

      get "/api/v1/invoice_items/#{invoice_item1.id}/invoice"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items["id"]).to eq(invoice_item1.id)

      get "/api/v1/invoice_items/#{invoice_item2.id}/invoice"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items["id"]).to eq(invoice_item2.id)
    end
  end

  context "GET /api/v1/invoice_items/:id/item" do
    it "returns the associated item" do
      customer = create(:customer)
      merchant = create(:merchant)
      item1 = create(:item)
      item2 = create(:item)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice.id, item: item1)
      invoice_item2 = create(:invoice_item, invoice_id: invoice.id, item: item2)

      get "/api/v1/invoice_items/#{invoice_item1.id}/item"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items["id"]).to eq(item1.id)

      get "/api/v1/invoice_items/#{invoice_item2.id}/item"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items["id"]).to eq(item2.id)
    end
  end

end
