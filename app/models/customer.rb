class Customer < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def favorite_merchant
    Merchant.joins(invoices: :transactions)
    .where(invoices: {customer_id: id})
    .merge(Transaction.success)
    .group('merchants.id')
    .order('count(merchants.id) DESC')
    .first
  end

end
