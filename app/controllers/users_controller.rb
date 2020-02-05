class UsersController < ApplicationController
  def show
    # require "pry"; binding.pry
    # github = User.github_repos
    #create instance variable to pass github repos to show page
    #create model method that makes call - perhaps use service here? Start with model
    #render json --- need to create serializer
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
