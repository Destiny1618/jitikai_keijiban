class Admin::EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.admin_id = current_admin.id
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
    @event_comment = EventComment.new
  end

  def edit
    @event = Event.find(params[:id])
    if @event.admin == current_admin
      render :edit
    else
      redirect_to events_path
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to event_path(@event.id)
    else
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    if event.admin
      event.destroy
    end
    redirect_to '/events'
  end

  def favorite_create
    event = Event.find(params[:event_id])
    if event.admin.== current_admin
      evemt.favorites.create(admin_id: current_admin.id)
    end
    redirect_back fallback_location: root_path
  end

  def favorite_destroy
    event = Post.find(params[:event_id])
    if event.admin.== current_admin
      event.favorites.find_by(admin_id: current_admin.id).destroy
    end
    redirect_back fallback_location: root_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :body)
  end
end
