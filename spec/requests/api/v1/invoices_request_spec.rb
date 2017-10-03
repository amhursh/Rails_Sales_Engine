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

    get "/api/v1/invoices/find?#{invoice3.status}"

    second_invoice = JSON.parse(response.body)

    expect(second_invoice["id"]).to eq invoice1.id
  end

  it "can find all invoices by params" do
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

    get "/api/v1/invoices/find_all?status=shipped"

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq 2

    get "/api/v1/invoices/find_all?customer_id=#{customer1.id}"

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq 2

    get "/api/v1/invoices/find_all?merchant_id=#{merchant1.id}"

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq 1
  end

  it "can find random invoice" do
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

    get "/api/v1/invoices/random"

    invoice = JSON.parse(response.body)

    Invoice.pluck(:id).include(invoice["id"])
  end
end
