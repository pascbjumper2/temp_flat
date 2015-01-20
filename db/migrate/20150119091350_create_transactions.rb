class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :address_2
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :phone
      t.string :email
      t.boolean :success
      t.boolean :complete

      t.timestamps
    end
  end
end
