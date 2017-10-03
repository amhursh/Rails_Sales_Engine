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
end