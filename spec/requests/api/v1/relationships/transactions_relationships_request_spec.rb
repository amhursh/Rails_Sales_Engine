require 'rails_helper'

describe "Transactions Relationships API" do
  it "sends the associated invoice" do
    invoice1 = create(:invoice)
    transaction = create(:transaction, invoice: invoice1)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq invoice1.id
  end
end
