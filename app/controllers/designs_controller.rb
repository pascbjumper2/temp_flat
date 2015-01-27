class DesignsController < ApplicationController

  def index

  end



  def create
    @design = Design.new(design_params)
    if @design.save
      redirect_to admin_path, notice: "The contact info has been successfully created."
    else
      render admin_path
    end
  end

  def edit
    @design = Design.find(params[:id])
  end

  def destroy
    @design = Design.find(params[:id])
    @design.destroy
    flash[:notice] = "Contact block removed!"
    redirect_to admin_path
  end

  def update
    @designs = Design.find(params[:id])
    if @designs.update_attributes(design_params)
      redirect_to admin_path, notice: "The contact information has been successfully updated."
    else
      render action: admin_path
    end
  end


  private

  def design_params
    params.require(:design).permit(:email, :sitename, :name, :phone, :address)
  end


end
