require 'rails_helper'

describe "Invoice Items API" do
  context "GET /invoice_items" do
    it "returns a list of invoice items" do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice.id, item: item)
      invoice_item2 = create(:invoice_item, invoice_id: invoice.id, item: item)
      invoice_item3 = create(:invoice_item, invoice_id: invoice.id, item: item)


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
      invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item: item)
      invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item: item)

      get "/api/v1/invoice_items/#{invoice_item1.id}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["invoice_id"]).to eq(invoice_item1.invoice_id)
    end
  end

  context "GET /invoice_item/find?params" do
    it "returns a single invoice item from params" do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item)
      invoice1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item: item)
      invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item: item)

      get "/api/v1/invoice_items/find?id=#{invoice_item1.id}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["invoice_id"]).to eq(invoice_item1.invoice_id)

      get "/api/v1/invoice_items/find?invoice_id=#{invoice_item2.invoice_id}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["id"]).to eq(invoice_item2.id)
    end
  end

  context "GET /invoice_item/find_all?params" do
    it "returns multiple invoice items from params" do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item)
      invoice1, invoice2 = create_list(:invoice, 2, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item: item, quantity: 5, unit_price: 1000)
      invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item: item, quantity: 5, unit_price: 1500)
      invoice_item3 = create(:invoice_item, invoice_id: invoice2.id, item: item, quantity: 2, unit_price: 1500)

      get "/api/v1/invoice_items/find_all?quantity=#{invoice_item1.quantity}"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.first["id"]).to eq(invoice_item1.id)

      get "/api/v1/invoice_items/find_all?invoice_id=#{invoice2.id}"

      invoice_items = JSON.parse(response.body)
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.last["id"]).to eq(invoice_item3.id)

      get "/api/v1/invoice_items/find_all?unit_price=#{invoice_item3.unit_price}"

      invoice_items = JSON.parse(response.body)
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.last["unit_price"]).to eq("15.0")
    end
  end

  context "GET /invoice_item/random" do
    it "returns a random invoice item" do
      customer = create(:customer)
      merchant = create(:merchant)
      item = create(:item)
      invoice1, invoice2 = create_list(:invoice, 2, merchant_id: merchant.id, customer_id: customer.id)
      invoice_item1 = create(:invoice_item, invoice_id: invoice1.id, item: item)
      invoice_item2 = create(:invoice_item, invoice_id: invoice2.id, item: item)

      get "/api/v1/invoice_items/random"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_item["id"]).to eq(invoice_item1.id).or eq(invoice_item2.id)
    end
  end
  
end
