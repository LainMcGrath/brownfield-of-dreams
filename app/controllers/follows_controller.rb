class FollowsController < ApplicationController

  def create
    Follow.create(follower_id: params[:follower_id], followee_id: params[:user_id])
    redirect_to dashboard_path
    flash[:notice] = "You are now friends with #{params[:follower_name]}"
  end
end
