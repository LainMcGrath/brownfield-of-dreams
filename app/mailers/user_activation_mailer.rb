class UserActivationMailer < ApplicationMailer
  def inform(user)
    @new_user = user
    mail(to: user.email, subject: 'Activate your account')
  end
end
