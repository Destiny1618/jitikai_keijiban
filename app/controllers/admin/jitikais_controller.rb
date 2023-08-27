class Admin::JitikaisController < ApplicationController
  before_action :authenticate_admin!
  def new
    @jitikai = Jitikai.new
  end

  def create
    @jitikai = Jitikai.new(jitikai_params)
    @jitikai.admin_id = current_admin.id
    if @jitikai.save
      redirect_to admin_jitikai_path(@jitikai.id)
    else
      @jitikai = Jitikai.published
      render :new
    end
  end

  def index
    @jitikais = Jitikai.published
    @jitikai = Jitikai.new
  end

  def show
    @jitikai = Jitikai.find(params[:id])
  end

  def edit
    @jitikai = Jitikai.find(params[:id])
    if @jitikai.admin == current_admin
      render :edit
    else
      redirect_to admin_jitikais_path
    end
  end

  def update
    @jitikai = Jitikai.find(params[:id])
    if @jitikai.update(jitikai_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to admin_jitikai_path(@jitikai.id)
    else
      render :edit
    end
  end

  def destroy
    jitikai = Jitikai.find(params[:id])
    jitikai.destroy if jitikai
    redirect_to '/admin/jitikais'
  end

  def favorite_create
    jitikai = Jitikai.find(params[:admin_jitikai_id])
    if jitikai.admin.!= current_admin
      jitikai.favorites.create(admin_id: current_admin.id)
    end
    redirect_back fallback_location: root_path
  end

  def favorite_destroy
    @jitikai = Jitikai.find(params[:admin_jitikai_id])
    if @jitikai.admin.!= current_admin
      @jitikai.favorites.find_by(admin_id: current_admin.id).destroy
    end
  end

  private

  def jitikai_params
    params.require(:jitikai).permit(:title, :body, :is_published_flag)
  end

end