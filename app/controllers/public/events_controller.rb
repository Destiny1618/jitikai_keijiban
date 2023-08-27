class Public::EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.customer_id = current_customer.id
    if !current_customer.guest? && @event.save!
      redirect_to events_path(@event.id)
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
    if !current_customer.guest? && @event.customer == current_customer
      render :edit
    else
      redirect_to events_path
    end
  end

  def update
    @event = Event.find(params[:id])
    if !current_customer.guest? && @event.update(event_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to event_path(@event.id)
    else
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    if !event.customer.guest?
      event.destroy
    end
    redirect_to '/events'
  end

  def favorite_create
    @event = Event.find(params[:event_id])
    if !current_customer.guest? && @event.customer != current_customer
      @event.favorites.create(customer_id: current_customer.id)
    end
  end

  def favorite_destroy
    @event = Event.find(params[:event_id])
    if !current_customer.guest?
      @event.favorites.find_by(customer_id: current_customer.id).destroy
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :body, :is_published_flag)
  end
end