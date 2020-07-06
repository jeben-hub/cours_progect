class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  default host: 'majestic-grand-canyon-79796.herokuapp.com'

  def activation_needed_email(user)
    @user = user
    mail(to: user.email, subject: "Account activation")
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: "Your account is now activated")
  end
end
