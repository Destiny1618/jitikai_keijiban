class Admin::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:admin_post_id])
    if comment = current_admin.post_comments.new(post_comment_params)
      comment.post_id = post.id
      comment.save
    end
    redirect_to admin_post_path(post)
  end

  private

  def post_comment_params
    params.permit(:comment)
  end
end
