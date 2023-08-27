class Public::JitikaisController < ApplicationController
  def index
    @jitikais = Jitikai.all
    @jitikai = Jitikai.new
  end

  def show
    @jitikai = Jitikai.find(params[:id])
  end

  def favorite_create
    @jitikai = Jitikai.find(params[:jitikai_id])
    if !current_customer.guest? && @jitikai.customer != current_customer
      @jitikai.favorites.create(customer_id: current_customer.id)
    end
  end

  def favorite_destroy
    @jitikai = Jitikai.find(params[:jitikai_id])
    if !current_customer.guest?
      @jitikai.favorites.find_by(customer_id: current_customer.id).destroy
    end
  end

end
