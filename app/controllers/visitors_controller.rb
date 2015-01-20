class VisitorsController < ApplicationController

  def index

    @products = Product.order("created_at DESC")
    @users = User.all
    @articles = Article.order("created_at DESC")
    @designs = Design.first
    @content_items = Content.all
  end

  def contact
    @designs = Design.first
  end

  def blog
    @articles = Article.order("created_at DESC")
  end

  def order
    @products = Product.order(:order)
  end

  def receive
    transaction = Transactionn.new(transaction_params)
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

      if transaction.stripe_card_token
        charge = Stripe::Charge.create(
          :amount => transaction.purchases.map(&:total).sum,
          :currency => 'usd',
          :card => transaction.stripe_card_token, # obtained with Stripe.js
          :description => "Charge for #{transaction.purchases.map(&:name).to_sentence}"
        )
        # rescue in case of stripe error
        # Set the transaction token as the charge id in case we want to view this later
        transaction.stripe_token = charge.id
        transaction.save
      end

      redirect_to checkout_path(:id => transaction.id)

    else
      redirect_to :back
    end


  end

  def checkout

  end


  private
    def transaction_params
      params.require(:transaction).permit(:stripe_card_token, :products)
    end


end