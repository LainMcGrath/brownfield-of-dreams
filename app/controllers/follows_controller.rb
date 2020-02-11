class FollowsController < ApplicationController
  def create
    Follow.create_friendship(params[:user_were_friending_id], current_user.id)
    redirect_to dashboard_path
    flash[:notice] = "You are now friends with #{params[:followee_name]}"
  end
end