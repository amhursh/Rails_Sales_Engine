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

end
