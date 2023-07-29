class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @jitikais = @customer.jitikais
    @events = @customer.events
    @dusts = @customer.dusts
  end

  def edit
    current_customer.email != "guest@example.com" && @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.email != "guest@example.com" && @customer.update(customer_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  private

  def customer_params
    params.require(:customer).permit(:name, :nickname, :email, :telephone_number, :encrypted_password)
  end
  
end
