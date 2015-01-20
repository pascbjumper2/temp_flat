class ChangeTransactionIdToTransactionnId < ActiveRecord::Migration
  def change
    rename_column :purchases, :transaction_id, :transactionn_id
  end
end
