class GalleriesController < ApplicationController

  def create

    @gallery = Gallery.new(gallery_params)

    if @gallery.save
      redirect_to admin_path
    else
      render admin_path
    end
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    #flash[:notice] = "Product removed!"
    redirect_to admin_path
  end

  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(gallery_params)
      redirect_to admin_path #, notice: "The product's information has been successfully updated."
    else
      render action: admin_path
    end
  end

private
  def gallery_params
    params.require(:gallery).permit(:order, :content_id, :width, :image)
  end

end
