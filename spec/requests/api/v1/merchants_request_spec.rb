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

  context "GET /merchants/find_all?params" do
    it "returns a multiple merchants from params" do
      merchant1 = create(:merchant, name: "Bob", created_at: "2017-04-20 00:00:00 UTC")
      merchant2 = create(:merchant, name: "Not Bob", created_at: "2017-04-20 00:00:00 UTC")
      merchant3 = create(:merchant, name: "Maybe Bob")

      get "/api/v1/merchants/find_all?created_at=#{merchant1.created_at}"

      merchants = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchants.count).to eq(2)
      expect(merchants.first["name"]).to eq(merchant1.name)
      expect(merchants.second["name"]).to eq(merchant2.name)

      get "/api/v1/merchants/find_all?name=#{merchant3.name}"

      merchant = JSON.parse(response.body)

      expect(response).to be_success
      expect(merchant.first["name"]).to eq(merchant3.name)

    end
  end


  context "GET /merchants/random" do
    it "returns a random merchant" do
      merchant1 = create(:merchant, name: "Bob")
      merchant2 = create(:merchant, name: "Not Bob")

      get "/api/v1/merchants/random"

      expect(response).to be_success
      expect(JSON.parse(response.body)["name"]).to eq(merchant1.name).or eq(merchant2.name)
    end
  end

end
