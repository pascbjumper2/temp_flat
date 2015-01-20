class Transactionn < ActiveRecord::Base
  has_many :purchases, dependent: :destroy
end
