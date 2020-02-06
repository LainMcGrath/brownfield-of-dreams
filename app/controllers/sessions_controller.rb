class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def github
      User.github_login(params)
     redirect_to user_repos_path
   end

    # def repos
    #   #collect repo information
    #
    #   response = Faraday.get("https://api.github.com/user/repos?access_token=#{current_user.token}")
    #
    #   repo_response = JSON.parse(response.body)
    #
    #   @display_repos = repo_response[0..4]
    #
    #   redirect_to dashboard_path
    # end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
