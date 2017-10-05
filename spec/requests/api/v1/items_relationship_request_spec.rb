require 'rails_helper'


# GET /api/v1/items/:id/invoice_items returns a collection of associated invoice items


describe "Items Relationships API" do

  context "GET /api/v1/items/:id/invoice_items" do
    it "returns a collection of associated invoice items" do
      customer = create(:customer)
      merchant = create(:merchant)
      item1 = create(:item)
      item2 = create(:item)
      invoice = create(:invoice, merchant: merchant, customer: customer)
      invoice_item1 = create(:invoice_item, invoice: invoice, item: item1)
      invoice_item2 = create(:invoice_item, invoice: invoice, item: item1)
      invoice_item3 = create(:invoice_item, invoice: invoice, item: item2)

      get "/api/v1/items/#{item1.id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.count).to eq(2)
      expect(invoice_items.first["id"]).to eq(invoice_item1.id)
      expect(invoice_items.last["id"]).to eq(invoice_item2.id)

      get "/api/v1/items/#{item2.id}/invoice_items"

      invoice_items = JSON.parse(response.body)

      expect(response).to be_success
      expect(invoice_items.first["id"]).to eq(invoice_item3.id)
    end
  end
# GET /api/v1/items/:id/merchant returns the associated merchant
  context "GET /api/v1/items/:id/merchant" do
    it "returns the associated merchant" do
      customer = create(:customer)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      item1 = create(:item, merchant: merchant1)
      item2 = create(:item, merchant: merchant2)
      invoice1 = create(:invoice, merchant: merchant1, customer: customer)
      invoice2 = create(:invoice, merchant: merchant2, customer: customer)
      invoice_item1 = create(:invoice_item, invoice: invoice1, item: item1)
      invoice_item2 = create(:invoice_item, invoice: invoice2, item: item2)

      get "/api/v1/items/#{item1.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(merchant1.id)

      get "/api/v1/items/#{item2.id}/merchant"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant["id"]).to eq(merchant2.id)
    end
  end

end
