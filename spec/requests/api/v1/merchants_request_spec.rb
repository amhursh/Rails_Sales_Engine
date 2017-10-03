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

end
