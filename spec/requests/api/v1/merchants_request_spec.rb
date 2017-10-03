require 'rails_helper'

describe "Merchants API" do

  context "GET /merchants" do
    it "returns a list of merchants" do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      items = JSON.parse(response.body)

      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end

  context "GET /merchants/id" do
    it "returns a single merchant" do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["id"]).to eq(merchant.id)
    end
  end

  context "GET /merchants/find?params" do
    it "returns a single merchant from params" do
      merchant1 = create(:merchant, name: "Bob")
      merchant2 = create(:merchant, name: "Not Bob", created_at: "2017-04-20 00:00:00 UTC")

      get "/api/v1/merchants/find?id=#{merchant1.id}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["name"]).to eq(merchant1.name)

      get "/api/v1/merchants/find?name=#{merchant2.name}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["name"]).to eq(merchant2.name)

    end
  end

  # # relationship endpoint
  # context "GET /merchants/:id/items" do
  #   it "returns all items for a merchant" do
      # merchant1 = create(:merchant, name: "Bob")
      # merchant2 = create(:merchant, name: "Not Bob")
  #     item1 = create(:item, merchant_id: merchant1.id, name: "Item1")
  #     item2 = create(:item, merchant_id: merchant1.id, name: "Item2")
  #     item3 = create(:item, merchant_id: merchant2.id, name: "Item3")
  #
  #     get "/api/v1/merchants/#{merchant1.id}/items"
  #     binding.pry
  #     expect(response).to be_success
  #
  #     expect(JSON.parse(response.body)["id"]).to eq(merchant.id)
  #   end
  # end

end
