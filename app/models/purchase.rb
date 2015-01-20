class Purchase < ActiveRecord::Base
  belongs_to :transactionns

  def total
    self.price + self.shipping
  end
end
