class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    if (user = User.find_by(email: params[:session][:email])) && user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def update
    user = User.find(session[:user_id])
    User.github_login(params, user)
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
