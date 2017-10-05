class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def self.total_revenue_for_date(date)
    Invoice.joins(:invoice_items, :transactions)
    .where(invoices: {created_at: date.to_datetime})
    .merge(Transaction.success)
    .sum("unit_price * quantity")
  end

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def revenue
    invoices.joins(:transactions, :invoice_items)
    .merge(Transaction.success)
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end
    
  def favorite_customer
    customers.joins(:transactions)
    .where(invoices: {merchant_id: id})
    .merge(Transaction.success)
    .group('customers.id')
    .order("count('customer.id') DESC")
    .first
  end

end
