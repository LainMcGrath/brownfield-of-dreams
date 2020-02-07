class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    if request.env['PATH_INFO'] == "/login"
      if (user = User.find_by(email: params[:session][:email])) && user&.authenticate(params[:session][:password])
        session[:user_id] = user.id
      else
        flash[:error] = 'Looks like your email or password is invalid'
        render :new
      end
    else
      user_info = request.env['omniauth.auth']
      current_user.uid = user_info[:uid]
      current_user.token = user_info[:credentials][:token]
      current_user.login = user_info[:extra][:raw_info][:login]
      current_user.save!
      session[:github] = current_user.login
    end
    redirect_to dashboard_path
  end

  def update
    user = User.find(session[:user_id])
    User.github_login(params, user)
    redirect_to dashboard_path
  end

  def destroy
    session[:github] = nil
    session[:user_id] = nil
    redirect_to root_path
  end
end
