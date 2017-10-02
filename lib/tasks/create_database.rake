require 'csv'


namespace :csv_maker do
  task :create_database do

    data = File.read('data/customers.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      Customer.create(row.to_hash)
    end

    data = File.read('data/merchants.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end

    data = File.read('/data/items.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end

    data = File.read('/data/invoices.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end

    data = File.read('/data/transactions.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end

    data = File.read('/data/invoice_items.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      Invoice_item.create!(row.to_hash)
    end

  end
end
