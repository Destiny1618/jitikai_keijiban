class Public::EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Evwnt.new(event_params)
    @event.customer_id = current_customer.id
    if @event.save
      redirect_to events_path(@event.id)
    else
      @events = Event.all
      render :index
    end
  end

  def index
    @events = Event.all
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @event = Event.find(params[:id])
    if @event.customer == current_customer
      render :edit
    else
      redirect_to events_path
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to '/events'
  end

  private

  def event_params
    params.require(:event).permit(:title, :body)
  end
end