class ChangeNumberToString < ActiveRecord::Migration
  def change
    change_column :transactionns, :phone, :string
  end
end
