class Admin::JitikaisController < ApplicationController
  def new
    @jitikai = Jitikai.new
  end

  def create
    @jitikai = Jitikai.new(jitikai_params)
    @jitikai.admin_id = current_admin.id
    if @jitikai.save
      redirect_to jitikais_path(@jitikai.id)
    else
      @dusts = Jitikai.all
      render :index
    end
  end

  def index
    @jitikais = Jitikai.all
    @jitikai = Jitikai.new
  end

  def show
    @jitikai = Jitikai.find(params[:id])
    @jitikai_comment = JitikaiComment.new
  end

  def edit
    @jitikai = Jitikai.find(params[:id])
    if @jitikai.admin == current_admin
      render :edit
    else
      redirect_to jitikais_path
    end
  end

  def update
    @jitikai = Jitikai.find(params[:id])
    if @jitikai.update(jitikai_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to jitikai_path(@jitikai.id)
    else
      render :edit
    end
  end

  def destroy
    jitikai = Jitikai.find(params[:id])
    if jitikai.admin
      jitikai.destroy
    end
    redirect_to '/jitikais'
  end

  def favorite_create
    jitikai = Jitikai.find(params[:jitikai_id])
    if jitikai.admin.== current_admin
      jitikai.favorites.create(admin_id: current_admin.id)
    end
    redirect_back fallback_location: root_path
  end

  def favorite_destroy
    jitikai = Jitikai.find(params[:jitikai_id])
    if jitikai.admin.== current_admin
      jitikai.favorites.find_by(admin_id: current_admin.id).destroy
    end
    redirect_back fallback_location: root_path
  end

  private

  def post_params
    params.require(:jitikai).permit(:title, :body)
  end
end
