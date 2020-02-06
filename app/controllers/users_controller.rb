class UsersController < ApplicationController
  def show
    
    response = Faraday.get("https://api.github.com/user/repos?access_token=#{current_user.token}")
    repo_response = JSON.parse(response.body)
    @display_repos = repo_response[0..4]
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

  def update
    User.github_login(params)
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
