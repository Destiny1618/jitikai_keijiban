class Public::JitikaisController < ApplicationController
  def index
    @jitikais = Jitikai.all
    @jitikai = Jitikai.new
  end

  def show
    @jitikai = Jitikai.find(params[:id])
  end
end
