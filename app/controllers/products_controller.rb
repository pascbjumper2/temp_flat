class ProductsController < ApplicationController

  def edit
    @product = Product.find(params[:id])
  end

  def create

    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_path
    else
      render admin_path
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Product removed!"
    redirect_to admin_path
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      redirect_to admin_path, notice: "The product's information has been successfully updated."
    else
      render action: admin_path
    end
  end







  private
  def product_params
    params.require(:product).permit(:name, :stock, :serial, :description, :price, :shipping, :order, :image, :size)
  end

end
