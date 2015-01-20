class CreateDesigns < ActiveRecord::Migration
  def change
    create_table :designs do |t|
      t.string :sitename
      t.string :email
      t.string :name
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
