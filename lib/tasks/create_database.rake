require 'csv'
require 'pry'


namespace :seed do
  task :create_database => :environment do

    data = File.read('data/customers.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      customer = Customer.create(row.to_hash)
      puts "Creating Customer: #{customer.first_name}"
    end

    data = File.read('data/merchants.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      merchant = Merchant.create!(row.to_hash)
      puts "Creating Merchant: #{merchant.name}"
    end

    data = File.read('data/items.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      item = Item.create!(row.to_hash)
      puts "Creating Item: #{item.name}"
    end

    data = File.read('data/invoices.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      invoice = Invoice.create!(row.to_hash)
      puts "Creating Invoice: #{invoice.id}"
    end

    data = File.read('data/transactions.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      transaction = Transaction.create!(row.to_hash)
      puts "Creating Transaction: #{transaction.id}"

    end

    data = File.read('data/invoice_items.csv')
    csv = CSV.parse(data, :headers => true)
    csv.each do |row|
      ii = InvoiceItem.create!(row.to_hash)
      puts "Creating InvoiceItem: #{ii.id}"
    end

  end
end
