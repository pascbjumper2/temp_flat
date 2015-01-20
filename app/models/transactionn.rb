class Transactionn < ActiveRecord::Base
  has_many :purchases, dependent: :destroy
  attr_accessor :products, :stripe_card_token
end
