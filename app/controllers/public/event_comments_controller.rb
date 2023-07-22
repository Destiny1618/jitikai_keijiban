class Public::EventCommentsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    comment = current_customer.event_comments.new(event_comment_params)
    comment.event_id = event.id
    comment.save
    redirect_to event_path(event)
  end

  private

  def event_comment_params
    params.require(:event_comment).permit(:comment)
  end
end
