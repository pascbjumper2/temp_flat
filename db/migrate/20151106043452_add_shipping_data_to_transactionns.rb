class AddShippingDataToTransactionns < ActiveRecord::Migration
  def change
    add_column :transactionns, :shipping_address, :string
    add_column :transactionns, :shipping_address_2, :string
    add_column :transactionns, :shipping_city, :string
    add_column :transactionns, :shipping_state, :string
    add_column :transactionns, :shipping_zip, :integer
  end
end
