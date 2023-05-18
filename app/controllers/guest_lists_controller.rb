class GuestListsController < ApplicationController
  before_action :find_event, :find_attendee
  before_action :require_login, only: [:create, :destroy]

  def create
    @event.attendees << @attendee 
    redirect_to current_user 
  end

  def destroy 
    @event.attendees.destroy(@attendee)
    redirect_to current_user 
  end

  private 

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_attendee
    @attendee = current_user
  end

  def require_login
    unless user_signed_in?
      flash[:error] = "You must sign in to alter attendance of an event."
      redirect_to new_user_session_path
    end
  end
end
