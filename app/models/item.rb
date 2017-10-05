class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_items(quantity)
    Item.find_by_sql(
    "SELECT items.*, sum(invoice_items.quantity) AS quantity
      FROM items
      JOIN invoice_items
          ON items.id = invoice_items.item_id
      JOIN invoices
          ON invoice_items.invoice_id = invoices.id
      JOIN transactions
          ON transactions.invoice_id = invoices.id
          WHERE transactions.result = 'success'
      GROUP BY items.id
      ORDER BY quantity DESC
      LIMIT #{quantity};"
    )
  end

end
