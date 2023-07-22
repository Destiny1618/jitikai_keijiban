class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @jitikais = @customer.jitikais
    @events = @customer.events
    @dusts = @customer.dusts
  end
  
  def edit
    
  end
end
