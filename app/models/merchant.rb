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
    .merge(Transaction.success)
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

  def revenue_by_date(date)
    invoices.joins(:transactions, :invoice_items)
    .where(invoices: {created_at: date.to_datetime})
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

  def self.most_items(quantity)
    Merchant.find_by_sql(
    "SELECT merchants.*, sum(invoice_items.quantity) AS quantity
      FROM merchants
      JOIN invoices
          ON merchants.id = invoices.merchant_id
      JOIN invoice_items
          ON invoices.id = invoice_items.invoice_id
      JOIN transactions
          ON transactions.invoice_id = invoices.id
      WHERE transactions.result = 'success'
      GROUP BY merchants.id
      ORDER BY quantity DESC
      LIMIT #{quantity};"
    )
  end

  def customers_with_pending_invoices
    Customer.find_by_sql(
      "SELECT customers.* FROM customers
      INNER JOIN invoices ON invoices.customer_id = customers.id
      INNER JOIN merchants ON invoices.merchant_id = merchants.id
      INNER JOIN transactions ON transactions.invoice_id = invoices.id
      WHERE merchants.id = #{id}
      AND transactions.result = 'failed'
      EXCEPT
      SELECT customers.* FROM customers
      INNER JOIN invoices ON invoices.customer_id = customers.id
      INNER JOIN merchants ON invoices.merchant_id = merchants.id
      INNER JOIN transactions ON transactions.invoice_id = invoices.id
      WHERE merchants.id = #{id}
      AND transactions.result = 'success'"
      )
  end

end
