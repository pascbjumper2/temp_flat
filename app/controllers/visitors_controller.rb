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
    #puts params.inspect
    #puts params['posted_array']


    a = params['posted_array']
    if a
      @transaction = Transactionn.new
      a.split(',').each do |x|
        next if x == "0"
        product = Product.find(x)
        purchase = @transaction.purchases.build
        purchase.name = product.name
        purchase.price = product.price
        purchase.shipping = product.shipping
        purchase.serial = product.serial
        @transaction.save
      end
      redirect_to checkout_path(:id => @transaction.id)

    else
      redirect_to :back
    end


  end

  def checkout

  end




end