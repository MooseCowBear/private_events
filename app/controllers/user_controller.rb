class UserController < ApplicationController
  def show
    @user = User.includes(:attended_events, :created_events, :guest_lists).find(params[:id])
  end
end
