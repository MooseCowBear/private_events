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
    @event = Event.find(params[:invite_only_event].to_i)
    @event.created_by?(current_user)
  end

  def confirm_user
    unless current_user && current_user.id == params[:id].to_i
      flash[:notice] = "A user's page is only viewable by that user."
      redirect_to root_path
    end
  end
end
