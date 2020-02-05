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
      client_id = '13bb7d4ef6b3c23576d2'
      client_secret = 'd1ba88fb71c5a1f99156628b3aa15a68741fa9e0'
      code = params[:code]
      response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

      pairs = response.body.split("&")
      response_hash = {}
      pairs.each do |pair|
        key, value = pair.split("=")
        response_hash[key] = value
      end

      token = response_hash["access_token"]

      oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

    auth = JSON.parse(oauth_response.body)
     current_user.uid = auth["id"]
     current_user.token = token
     current_user.save
     # require "pry"; binding.pry
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
