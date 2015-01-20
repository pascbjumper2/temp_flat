class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :stock
      t.string :name
      t.integer :serial
      t.text :description
      t.decimal :price
      t.decimal :shipping
      t.integer :order

      t.timestamps
    end
  end
end
