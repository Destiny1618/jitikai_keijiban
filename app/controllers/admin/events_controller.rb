class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.admin_id = current_admin.id
    if @event.save
      redirect_to admin_event_path(@event.id)
    else
      @events = Event.all
      render :index
    end
  end

  def index
    @events = Event.published
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
      redirect_to admin_events_path
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to admin_event_path(@event.id)
    else
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy if event
    redirect_to '/admin/events'
  end

  def favorite_create
    event = Event.find(params[:admin_event_id])
    if event.admin.!= current_admin
      event.favorites.create(admin_id: current_admin.id)
    end
    redirect_back fallback_location: root_path
  end

  def favorite_destroy
    @event = Event.find(params[:admin_event_id])
    if @event.admin.!= current_admin
      @event.favorites.find_by(admin_id: current_admin.id).destroy
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :body, :is_published_flag)
  end

end