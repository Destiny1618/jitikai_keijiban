class Public::DustsController < ApplicationController
  def index
    @dusts = Dust.all
    @dust = Dust.new
  end

  def show
    @dust = Dust.find(params[:id])
  end
end