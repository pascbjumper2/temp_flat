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


  def update
    @designs = Design.first
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
