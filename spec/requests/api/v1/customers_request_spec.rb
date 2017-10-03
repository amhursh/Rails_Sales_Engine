require 'rails_helper'

describe "Customers API" do

  context "GET /customers" do
    it "returns a list of customers" do
      create_list(:customer, 3)

      get '/api/v1/customers'

      customers = JSON.parse(response.body)

      expect(response).to be_success
      expect(customers.count).to eq(3)
    end
  end

  context "GET /customers/id" do
    it "returns a single customer" do
      customer = create(:customer)

      get "/api/v1/customers/#{customer.id}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["id"]).to eq(customer.id)
    end
  end

  context "GET /customers/find?params" do
    it "returns a single customer from params" do
      customer1 = create(:customer, first_name: "Bob", last_name: "Lowlaw")
      customer2 = create(:customer, first_name: "The", last_name: "Fonz")

      get "/api/v1/customers/find?first_name=#{customer1.first_name}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["last_name"]).to eq(customer1.last_name)

      get "/api/v1/customers/find?last_name=#{customer2.last_name}"

      expect(response).to be_success
      expect(JSON.parse(response.body)["first_name"]).to eq(customer2.first_name)

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
