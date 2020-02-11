class FollowsController < ApplicationController

  def create
    require "pry"; binding.pry
    Follow.create!(follower_id: params[:follower_id], followee_id: params[:user_id])
  end
end
