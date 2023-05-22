class GuestListsController < ApplicationController
  before_action :require_login, :find_attendee

  def create
    @event = Event.find(params[:event_id])
    @guest = @event.guest_lists.new(attendee: @attendee)

    if @event.private && @event.created_by?(@attendee)
      @guest = @event.guest_lists.new(attendee: @attendee, accepted: true)
    end

    if @guest.save
      flash[:notice] = "Guest list was successfully updated."
    else 
      flash.now[:notice] = "Something went wrong."
    end
    redirect_to event_path(@event)
  end

  def destroy 
    @event = Event.find(params[:event_id])
    @event.attendees.destroy(@attendee)
    flash[:notice] = "Guest list was successfully updated."
    redirect_to event_path(@event)
  end

  def edit 
    @guest = GuestList.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @guest = GuestList.find(params[:id]) 

    if @guest.update(accepted: params[:accept])
      flash[:notice] = "Thank you for your response."
    else
      flash[:notice] = "Something went wrong."
    end
    redirect_to event_path(@event)
  end

  private 

  def find_attendee
    @attendee = invitee || current_user 
  end

  def invitee 
    User.find(params[:user_id]) if params[:user_id]
  end
end
