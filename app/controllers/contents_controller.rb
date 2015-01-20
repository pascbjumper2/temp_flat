class ContentsController < ApplicationController

  def edit
    @content = Content.find(params[:id])
  end

  def create

    @content = Content.new(content_params)

    if @content.save
      redirect_to admin_path
    else
      render admin_path
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    flash[:notice] = "Content block removed!"
    redirect_to admin_path
  end

  def update
    @content = Content.find(params[:id])
    if @content.update_attributes(content_params)
      redirect_to admin_path, notice: "The content block has been successfully updated."
    else
      render action: admin_path
    end
  end


  private
  def content_params
    params.require(:content).permit(:category, :title, :body, :order)
  end

end
