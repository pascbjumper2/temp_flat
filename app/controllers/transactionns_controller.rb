class TransactionnsController < ApplicationController

  def index
    redirect_to admin_path
  end

  def destroy
    @transaction = Transactionn.find(params[:id])
    @transaction.destroy
    flash[:notice] = "Order removed!"
    redirect_to admin_path
  end

  def post
    @transaction = Transactionn.find(params[:id])
    @transaction.complete = true
    @transaction.save

    flash[:notice] = "Order marked as complete!"
    redirect_to admin_path
  end

  def show
    redirect_to admin_path
  end

end
