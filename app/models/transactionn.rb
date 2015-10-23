class Transactionn < ActiveRecord::Base
  has_many :purchases, dependent: :destroy
  attr_accessor :products, :stripe_card_token

  def full_shipping_address
    if shipping_address
      shipping_address + ', ' + shipping_city + ', ' + shipping_state + ', ' + shipping_zip.to_s
    else
      address + ', ' + city + ', ' + state + ', ' + zip.to_s
    end


  end



end

