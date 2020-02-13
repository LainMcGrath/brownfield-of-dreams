class UserInviteMailer < ApplicationMailer
  def inform(current_user, friend_email, friend_login)
    @login = friend_login
    @sender = current_user
    mail(to: friend_email, subject: "#{@sender.login} wants you to join their app!")
  end
end
