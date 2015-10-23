class VisitorsController < ApplicationController
  require "net/http"
  require "uri"

  def index

    @products = Product.order("created_at DESC")
    @users = User.all
    @articles = Article.order("created_at DESC")
    @designs = Design.first
    @content_items = Content.all
  end

  def contact
    @designs = Design.all
  end

  def blog
    @articles = Article.order("created_at DESC")
  end

  def order
    @products = Product.order(:order)
  end

  def receive
    transaction = Transactionn.new(transaction_params)

    # Unless the cart is empty, record the transaction
    if transaction.products.present?
      transaction.products.split(',').each do |x|
        next if x == '0'
        product = Product.find(x)
        purchase = transaction.purchases.build
        purchase.name = product.name
        purchase.price = product.price
        purchase.shipping = product.shipping
        purchase.serial = product.serial
        purchase.save

        transaction.save
      end

      # rescue in case of stripe error
      if transaction.stripe_card_token

        # Define default errors and redirect path
        redirect_path =  checkout_path
        stripe_errors = nil

        begin
          charge = Stripe::Charge.create(
            :amount => transaction.purchases.map(&:total).sum,
            :currency => 'usd',
            :card => transaction.stripe_card_token, # obtained with Stripe.js
            :description => "Charge for #{transaction.purchases.map(&:name).to_sentence}"
          )

          # Set the transaction token as the charge id in case we want to view this later
          transaction.stripe_token = charge.id

          # Save the user's data
          transaction.first_name = charge.card.name
          transaction.address = charge.card.address_line1
          transaction.address_2 = charge.card.address_line2
          transaction.city = charge.card.address_city
          transaction.state = charge.card.address_state
          transaction.zip = charge.card.address_zip
          b = params["transaction"]
          transaction.email = b["email"]
          transaction.phone = b["cell"]
          @record = transaction
          transaction.save

          # Email user a receipt
          ModelMailer.new_record_notification(@record).deliver

          # Send owner a text with error
          send_text(ENV['PHONE_NUMBER'], 'A purchase has been made at flatjack.com')

        rescue Stripe::InvalidRequestError,
               Stripe::AuthenticationError,
               Stripe::APIConnectionError,
               Stripe::StripeError => e

          # Send developer a text with error
          send_text(ENV['DEV_PHONE_NUMBER'], 'Failed purchase: ' + e.to_s + 'Value: $' + (transaction.purchases.map(&:total).sum / 100.00).to_s)

          # Define errors and redirect path
          stripe_errors = e
          redirect_path =  order_path
        end
        
      end
      flash[:danger] = 'Error: ' + e.to_s if stripe_errors
      redirect_to redirect_path
    end


  end

  def checkout

  end


  private
    def transaction_params
      params.require(:transaction).permit(:stripe_card_token, :products, :shipping_address, :shipping_city, :shipping_state, :shipping_zip)
    end

    def send_text(number, message)
      uri = URI.parse 'http://textbelt.com/text'
      Net::HTTP.post_form(uri, {'number' => number, 'message' => ('FlatJack: ' + message)})
    end

end