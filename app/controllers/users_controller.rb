class UsersController < ApplicationController
  def show
    # user = User.find(session[:user_id])
    user = User.find(current_user.id)
    
    if user.token
      render locals: {
        display_repos: User.fetch_repos(user.id)
      }
    end
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
