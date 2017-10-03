require 'rails_helper'

describe "Invoices API" do
	it "sends a list of all invoices" do
		customer = create(:customer)
		merchant = create(:merchant)

		invoice1, invoice2, invoice3 = create_list(:invoice, 3, customer: customer, merchant: merchant)

		get '/api/v1/invoices'

		invoices = JSON.parse(response.body)

		expect(response).to be_success
		expect(invoices.count).to eq 3
	end

	it "can get one item by its id" do
		customer = create(:customer)
		merchant = create(:merchant)

		invoice1, invoice2, invoice3 = create_list(:invoice, 3, customer: customer, merchant: merchant)

		get "/api/v1/invoices/#{invoice2.id}"

		invoice = JSON.parse(response.body)

		expect(response).to be_success
		expect(invoice["id"]).to eq invoice2.id
		expect(invoice["id"]).to_not eq invoice1.id
		expect(invoice["id"]).to_not eq invoice3.id
	end

	it "can find individual invoice by params" do
		customer1, customer2 = create_list(:customer, 2)
		merchant1, merchant2 = create_list(:merchant, 2)

		invoice1 = create(:invoice,
											customer: customer1, 
											merchant: merchant1, 
											created_at: "2017-05-20 00:00:00 UTC",
											updated_at: "2017-05-21 00:00:00 UTC",
											status: "shipped"
											)
		invoice2 = create(:invoice,
											customer: customer2,
											merchant: merchant2,
											created_at: "2017-04-20 00:00:00 UTC",
											updated_at: "2017-04-21 00:00:00 UTC",
											status: "cancelled"
											)
		invoice3 = create(:invoice, 
											customer: customer1,
											merchant: merchant2,
											created_at: "2017-03-20 00:00:00 UTC",
											updated_at: "2017-03-21 00:00:00 UTC",
											status: "shipped"
											)

		get "/api/v1/invoices/find?#{invoice1.created_at}"

		invoice = JSON.parse(response.body)

		expect(invoice["id"]).to eq invoice1.id

		get "/api/v1/invoices/find?#{invoice2.updated_at}"

		invoice = JSON.parse(response.body)

		expect(invoice["id"]).to eq invoice2.id

		get "/api/v1/invoices/find?#{invoice3.status}"

		expect(invoice["id"]).to eq invoice1.id
		expect(invoice.count).to eq 1
	end
end