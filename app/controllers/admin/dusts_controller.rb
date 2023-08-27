class Admin::DustsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @dust = Dust.new
  end

  def create
    @dust = Dust.new(dust_params)
    @dust.admin_id = current_admin.id
    if @dust.save
      redirect_to admin_dusts_path(@dust.id)
    else
      @dusts = Dust.new
      render :new
    end
  end

  def index
    @dusts = Dust.all
    @dust = Dust.new
  end

  def show
    @dust = Dust.find(params[:id])
  end

  def edit
    @dust = Dust.find(params[:id])
    if @dust.admin == current_admin
      render :edit
    else
      redirect_to admin_dusts_path
    end
  end

  def update
    @dust = Dust.find(params[:id])
    if @dust.update(dust_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to admin_dust_path(@dust.id)
    else
      render :edit
    end
  end

  def destroy
    dust = Dust.find(params[:id])
    dust.destroy if Dust
    redirect_to '/admin/dusts'
  end

  def favorite_create
    dust = Dust.find(params[:admin_dust_id])
    if dust.admin.!= current_admin
      dust.favorites.create(admin_id: current_admin.id)
    end
    redirect_back fallback_location: root_path
  end

  def favorite_destroy
    @dust = Dust.find(params[:admin_dust_id])
    if @dust.admin.!= current_admin
      @dust.favorites.find_by(admin_id: current_admin.id).destroy
    end
  end

  private

  def dust_params
    params.require(:dust).permit(:title, :body, :is_published_flag)
  end

end