class Admin::EventCommentsController < ApplicationController
  def create
    event = Event.find(params[:admin_event_id])
    if comment = current_admin.event_comments.new(event_comment_params)
      comment.event_id = event.id
      comment.save
    end
    redirect_to admin_event_path(event)
  end

  private

  def event_comment_params
    params.permit(:comment)
  end
end
