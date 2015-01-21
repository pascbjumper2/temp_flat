class AdminController < ApplicationController

	before_filter :redirect

	def redirect
		redirect_to root_path unless current_user.try(:role) == "admin"
	end

	def index
 		@product = Product.new
		@products = Product.order(:order)
		@users = User.all
		@article = Article.new
		@articles = Article.order("created_at DESC")
		@design = Design.new
		@designs = Design.first
		@content = Content.new
		@content_items = Content.all
		@gallery = Gallery.new
		puts @post || "No"
		@transactions = Transactionn.all.order("id DESC")
	end



end
