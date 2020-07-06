class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    mail(to: user.email, subject: "Account activation").deliver
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: "Your account is now activated").deliver
  end
end
