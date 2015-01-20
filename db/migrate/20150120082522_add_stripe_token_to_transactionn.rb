class AddStripeTokenToTransactionn < ActiveRecord::Migration
  def change
    add_column :transactionns, :stripe_token, :string
  end
end
