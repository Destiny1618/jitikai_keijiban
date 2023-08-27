class Public::DustsController < ApplicationController
  def index
    @dusts = Dust.all
    @dust = Dust.new
  end

  def show
    @dust = Dust.find(params[:id])
  end

  def favorite_create
    @dust = Dust.find(params[:dust_id])
    if !current_customer.guest? && @dust.customer != current_customer
      @dust.favorites.create(customer_id: current_customer.id)
    end
  end

  def favorite_destroy
    @dust = Dust.find(params[:dust_id])
    if !current_customer.guest?
      @dust.favorites.find_by(customer_id: current_customer.id).destroy
    end
  end
end