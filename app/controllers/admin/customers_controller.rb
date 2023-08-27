class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @customers = Customer.all.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "顧客情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    #byebug
    if @customer.destroy
      redirect_to admin_customers_path, notice: "顧客情報を破棄しました"
    else
      redirect_to '/customer/:id'
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name,:nickname,:telephone_number,:email,:is_deleted)
  end

end