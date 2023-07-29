class Admin::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.admin_id = current_admin.id
    if @post.save
      redirect_to posts_path(@post.id)
    else
      @posts = Post.all
      render :index
    end
  end

  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.admin == current_admin
      render :edit
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.admin == current_admin
      post.destroy
    end
    redirect_to '/posts'
  end

  def favorite_create
    post = Post.find(params[:post_id])
    if post.admin.== current_admin
      post.favorites.create(admin_id: current_admin.id)
    end
    redirect_back fallback_location: root_path
  end

  def favorite_destroy
    post = Post.find(params[:post_id])
    if post.admin.== current_admin
      post.favorites.find_by(admin_id: current_admin.id).destroy
    end
    redirect_back fallback_location: root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
