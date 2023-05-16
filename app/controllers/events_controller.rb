class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new 
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)
  end

  private 

  def event_params
    params.require(:event).permit(:name, :location)
  end
end
