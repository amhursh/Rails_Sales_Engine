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

  context "GET /customers/find_all?params" do
    it "returns a single customer from params" do
      customer1 = create(:customer, first_name: "Bob", last_name: "Lowlaw")
      customer2 = create(:customer, first_name: "The", last_name: "Fonz")
      customer3 = create(:customer, first_name: "The", last_name: "Dude")

      get "/api/v1/customers/find_all?first_name=#{customer2.first_name}"

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(2)
      expect(customers.first["last_name"]).to eq(customer2.last_name)

      get "/api/v1/customers/find?last_name=#{customer1.last_name}"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer["first_name"]).to eq(customer1.first_name)

    end
  end

  context "GET /customers/random" do
    it "returns a random customer" do
      customer1 = create(:customer, first_name: "Bob", last_name: "Lowlaw")
      customer2 = create(:customer, first_name: "The", last_name: "Fonz")
      customer3 = create(:customer, first_name: "The", last_name: "Dude")

      get "/api/v1/customers/random"

      customer = JSON.parse(response.body)

      expect(response).to be_success
      expect(customer.class).to eq(Hash)

    end
  end

end
