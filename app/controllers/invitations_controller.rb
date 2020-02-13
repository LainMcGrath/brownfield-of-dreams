class InvitationsController < ApplicationController
  def create
    friend_email = GithubService.new.get_email_from_handle(params[:github_handle], current_user.token)    
    if friend_email == 'error'
      flash[:notice] = "Github user not found."
    elsif friend_email.first.nil?
      flash[:notice] = 'This user did not have an email on Github.'
    else
      UserInviteMailer.inform(current_user, friend_email[0], friend_email[1]).deliver_now
      flash[:success] = 'Successfully sent invite!'
    end
    redirect_to dashboard_path
  end
end