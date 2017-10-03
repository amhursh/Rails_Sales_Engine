require 'rails_helper'

describe "Invoice Index API" do
	it "sends a list of all invoices" do
		customer = create(:customer)
		merchant = create(:merchant)

		invoice1, invoice2, invoice3 = create_list(:invoice, 3, customer: customer, merchant: merchant)

		get '/api/v1/invoices'

		invoices = JSON.parse(response.body)

		expect(response).to be_success
		expect(items.count).to eq 3
	end
end