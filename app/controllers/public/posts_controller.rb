class Public::PostsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if !current_customer.guest? && @post.save!
      redirect_to posts_path(@post.id)
    else
      @posts = Post.all
      render :index
    end
  end

  def index
    @posts = Post.published
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    if !current_customer.guest? && @post.customer == current_customer
      render :edit
    else
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if !current_customer.guest? && @post.update(post_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if !post.customer.guest?
      post.destroy
    end
    redirect_to '/posts'
  end

  def favorite_create
    @post = Post.find(params[:post_id])
    if !current_customer.guest? && @post.customer != current_customer
      @post.favorites.create(customer_id: current_customer.id)
    end
  end

  def favorite_destroy
    @post = Post.find(params[:post_id])
    if !current_customer.guest?
      @post.favorites.find_by(customer_id: current_customer.id).destroy
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :is_published_flag)
  end
end