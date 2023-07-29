class Public::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    if current_customer.email != "guest@example.com" && comment = current_customer.post_comments.new(post_comment_params)
      comment.post_id = post.id
      comment.save
    end
    redirect_to post_path(post)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
