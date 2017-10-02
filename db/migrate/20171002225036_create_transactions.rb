class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :invoice_id, foreign_key: true
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.integer :result

      t.timestamps
    end
  end
end
