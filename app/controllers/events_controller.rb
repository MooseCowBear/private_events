class EventsController < ApplicationController
  before_action :require_login, only: [:new, :create, :update, :destroy]
  before_action :invited, only: [:show]

  def index
    @public_upcoming_events = Event.upcoming.public_event
    @public_past_events = Event.past.public_event
  end

  def new 
    @event = Event.new
  end

  def show 
    @event = Event.find(params[:id])
    if @event.private
      @accepted_invites = @event.attendees.where("guest_lists.accepted = ?", true)
    end
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

  def event_params
    params.require(:event).permit(:name, :location, :event_date, :event_time, :description, :private)
  end

  def invited
    @event = Event.find(params[:id])
    unless @event.access_private?(current_user) 
      flash[:notice] = "You must be invited to view a private event."
      redirect_to root_path
    end
  end
end
