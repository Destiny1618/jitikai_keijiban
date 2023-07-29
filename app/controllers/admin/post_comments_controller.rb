class Admin::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    if comment = current_admin.post_comments.new(post_admin_params)
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
