class GuestListsController < ApplicationController
  #where will the links to these actions go? in the user's show page
  before_action :find_event, :find_attendee
  before_action :require_login, only: [:create, :destroy]

  def create
    puts "in the create action"
    @event.attendees << @attendee #if no curr user, then will fail..
    redirect_to current_user #is this what you want?
  end

  def destroy 
    puts "in the destroy action"
    @event.attendees.destroy(@attendee)
    redirect_to current_user #same as above
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
