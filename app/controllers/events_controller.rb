class EventsController < ApplicationController
  before_action :require_login, only: [:new, :create, :update, :destroy]

  def index
    @events = Event.all
  end

  def new 
    @event = Event.new
  end

  def show 
    @event = Event.find(params[:id])
  end

  def create
    @event = current_user.created_events.new(event_params)

    if @event.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update 
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    @event = Event.find(params[:id])
    @event.destroy
  
    redirect_to root_path, status: :see_other
  end

  private 
  def require_login
    unless user_signed_in?
      flash[:error] = "You must sign in to add an event."
      redirect_to new_user_session_path
    end
  end

  def event_params
    params.require(:event).permit(:name, :location, :event_date, :event_time, :description, :private)
  end
end
