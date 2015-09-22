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

    # If the cart isn't empty, record the transaction
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
          ModelMailer.new_record_notification(@record).deliver

          uri = URI.parse 'http://textbelt.com/text'
          Net::HTTP.post_form(uri, {'number' => ENV['PHONE_NUMBER'], 'message' => 'A purchase has been made at flatjack.com'})

        rescue Stripe::InvalidRequestError,
               Stripe::AuthenticationError,
               Stripe::APIConnectionError,
               Stripe::StripeError => e
          #Send Josh a text
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
      params.require(:transaction).permit(:stripe_card_token, :products)
    end

end