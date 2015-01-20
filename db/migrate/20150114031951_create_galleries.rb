class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.integer :order
      t.integer :width
      t.references :content, index: true

      t.timestamps
    end
  end
end
