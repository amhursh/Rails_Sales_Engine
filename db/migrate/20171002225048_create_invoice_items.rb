class CreateInvoiceItems < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_items do |t|
      t.string :item_id
      t.string :references
      t.references :invoice_id, foreign_key: true
      t.integer :quantity
      t.integer :unit_price

      t.timestamps
    end
  end
end
