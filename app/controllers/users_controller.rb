class UsersController < ApplicationController
  def show
    user = User.find(current_user.id)
    if session[:github]
      render locals: {
        user: GithubUser.new(current_user.token)
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
      UserActivationMailer.inform(user).deliver_now
      redirect_to dashboard_path
      flash[:success] = "Logged in as #{user_params[:email]}. This account has not yet been activated. Please check your email."
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    user = User.find(params[:user_id])
    user.update(activated?: true)
    redirect_to dashboard_path
    flash[:success] = 'Thanks for activating buddy :)'
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
