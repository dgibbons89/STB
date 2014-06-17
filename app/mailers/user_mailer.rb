class UserMailer < ActionMailer::Base
  default from: "dgibbons712@gmail.com"

  def welcome_email(user)
  	@user = user
  	mail to: user.email, subject: "Thanks for signing up"
  end
end
