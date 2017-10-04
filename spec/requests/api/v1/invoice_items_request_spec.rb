require 'rails_helper'

describe "Invoice Items API" do
  context "GET /invoice_items" do
    it "returns a list of invoice items" do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice.id)
      invoice_item2 = create(:invoice_item, invoice_id: invoice.id)
      invoice_item3 = create(:invoice_item, invoice_id: invoice.id)


      get '/api/v1/invoice_items'

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(3)
    end
  end

  context "GET /invoice_items/id" do
    it "returns a single invoice item" do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item)
      invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice1.id)
      invoice_item2 = create(:invoice_item, invoice_id: invoice2.id)

      get "/api/v1/invoice_items/#{invoice_item1.id}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["invoice_id"]).to eq(invoice_item1.invoice_id)
    end
  end

  context "GET /invoice_item/find?params" do
    it "returns a single transaction from params" do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item)
      invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice1.id)
      invoice_item2 = create(:invoice_item, invoice_id: invoice2.id)

      get "/api/v1/invoice_items/find?id=#{invoice_item1.id}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["invoice_id"]).to eq(invoice_item1.invoice_id)

      get "/api/v1/invoice_items/find?invoice_id=#{invoice_item2.invoice_id}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["id"]).to eq(invoice_item2.id)

    end
  end

end
