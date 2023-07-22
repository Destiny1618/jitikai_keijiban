class Public::FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: post.id)
    favorite.save
    redirect_to post_path(post)
    jitikai = Jitikai.find(params[:jitikai_id])
    favorite = current_customer.favorites.new(jitikai_id: jitikai.id)
    favorite.save
    redirect_to jitikai_path(jitikai)
    event = Event.find(params[:event_id])
    favorite = current_customer.favorites.new(event_id: event.id)
    favorite.save
    redirect_to event_path(event)
    dust = Dust.find(params[:dust_id])
    favorite = current_customer.favorites.new(dust_id: dust.id)
    favorite.save
    redirect_to dust_path(dust)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to post_path(post)
    jitikai = Jitikai.find(params[:jitikai_id])
    favorite = current_customer.favorites.find_by(jitikai_id: jitikai.id)
    favorite.destroy
    redirect_to jitikai_path(jitikai)
    event = Event.find(params[:event_id])
    favorite = current_customer.favorites.find_by(event_id: event.id)
    favorite.destroy
    redirect_to event_path(event)
    dust = Dust.find(params[:dust_id])
    favorite = current_customer.favorites.find_by(dust_id: dust.id)
    favorite.destroy
    redirect_to dust_path(dust)
  end
end
