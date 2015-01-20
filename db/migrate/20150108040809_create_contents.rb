class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :category
      t.string :title
      t.text :body
      t.integer :order

      t.timestamps
    end
  end
end
