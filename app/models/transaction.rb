class Transaction < ActiveRecord::Base
  has_many :purchases
end
