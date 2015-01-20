class AdminController < ApplicationController

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
	end



end
