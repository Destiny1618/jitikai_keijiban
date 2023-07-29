class Admin::DustsController < ApplicationController
  def new
    @dust = Dust.new
  end

  def create
    @dust = Dust.new(dust_params)
    @dust.admin_id = current_admin.id
    if @dust.save
      redirect_to dusts_path(@dust.id)
    else
      @dusts = Dust.all
      render :index
    end
  end

  def index
    @dusts = Dust.all
    @dust = Dust.new
  end

  def show
    @dust = Dust.find(params[:id])
    @dust_comment = DustComment.new
  end

  def edit
    @dust = Dust.find(params[:id])
    if @dust.admin == current_admin
      render :edit
    else
      redirect_to dusts_path
    end
  end

  def update
    @dust = Dust.find(params[:id])
    if @dust.update(dust_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to dust_path(@dust.id)
    else
      render :edit
    end
  end

  def destroy
    dust = Dust.find(params[:id])
    if dust.admin
      dust.destroy
    end
    redirect_to '/dusts'
  end

  def favorite_create
    dust = Dust.find(params[:dust_id])
    if dust.admin.== current_admin
      dust.favorites.create(admin_id: current_admin.id)
    end
    redirect_back fallback_location: root_path
  end

  def favorite_destroy
    dust = Dust.find(params[:dust_id])
    if dust.admin.== current_admin
      dust.favorites.find_by(admin_id: current_admin.id).destroy
    end
    redirect_back fallback_location: root_path
  end

  private

  def post_params
    params.require(:dust).permit(:title, :body)
  end
end
