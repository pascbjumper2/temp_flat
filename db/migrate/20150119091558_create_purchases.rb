class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name
      t.integer :price
      t.integer :shipping
      t.integer :serial
      t.string :transaction_id

      t.timestamps
    end
  end
end
