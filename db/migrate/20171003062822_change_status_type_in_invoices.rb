class ChangeStatusTypeInInvoices < ActiveRecord::Migration[5.1]
  def self.up
  	change_column :invoices, :status, :string
  end

  def self.down
  	change_column :invoices, :status, :integer
  end
end
