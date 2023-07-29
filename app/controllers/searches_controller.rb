class SearchesController < ApplicationController
  def search
    @range = params[:range]
    if @range == "Post"
      @posts = Post.looks(params[:search], params[:word])
    elsif @range == "Event"
      @events = Event.looks(params[:search], params[:word])
    elsif @range == "Jitikai"
      @jitikais = Jitikai.looks(params[:search], params[:word])
    elsif @range == "Dust"
      @dusts = Dust.looks(params[:search], params[:word])
    end
  end
end
