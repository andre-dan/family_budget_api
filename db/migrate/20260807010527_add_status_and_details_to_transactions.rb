class AddStatusAndDetailsToTransactions < ActiveRecord::Migration[8.1]
  def change
    add_column :transactions, :status, :string
    add_column :transactions, :payment_method, :string
    add_column :transactions, :customer_name, :string
    add_column :transactions, :due_date, :date
  end
end
