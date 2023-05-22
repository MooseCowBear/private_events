class GuestListsController < ApplicationController
  before_action :require_login, :find_attendee

  def create
    @guest = Event.find(params[:event_id]).guest_lists.new(attendee_id: @attendee.id)

    if @guest.save
      flash[:notice] = "Guest list was successfully updated."
      redirect_to current_user
    else 
      flash.now[:notice] = "Something went wrong."
      render event_path(@event.id)
    end
  end

  def destroy 
    @event = Event.find(params[:event_id])
    @event.attendees.destroy(@attendee)
    redirect_to current_user 
  end

  def edit 
    @guest = GuestList.find(params[:id])
  end

  def update
    @guest = GuestList.find(params[:id]) 

    if @guest.update(accepted: params[:accept])
      flash[:notice] = "Thank you for your response."
      redirect_to current_user
    else
      flash[:notice] = "Something went wrong."
      redirect_to event_path(params[:event_id])
    end
  end

  private 

  def find_attendee
    @attendee = invitee || current_user 
  end

  def invitee 
    User.find(params[:user_id]) if params[:user_id]
  end
end
