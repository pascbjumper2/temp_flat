class AddSizeToProduct < ActiveRecord::Migration
  def change
    add_column :products, :size, :integer
  end
end
