class UserController < ApplicationController
  before_action :confirm_ownership, only: [:index]
  before_action :confirm_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_created_events = @user.created_events.includes(:creator)
    @user_upcoming_events = @user.attended_events.upcoming
    @user_past_events = @user.attended_events.past
  end

  private

  def confirm_ownership
    if params[:invite_only_event]
      @event = Event.find(params[:invite_only_event])
      unless @event.created_by?(current_user)
        flash[:notice] = "Only creators of private events may set the guess list."
        redirect_to user_path(current_user.id) if current_user
        redirect_to root_path unless current_user
      end
    else
      flash[:notice] = "Only private events may set a guest list."
      redirect_to root_path  
    end
  end

  def confirm_user
    unless current_user && current_user.id == params[:id].to_i
      flash[:notice] = "A user's page is only viewable by that user."
      redirect_to root_path
    end
  end
end
