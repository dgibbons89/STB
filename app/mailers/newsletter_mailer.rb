class NewsletterMailer < ActionMailer::Base
  default from: "from@example.com"

  def thanks(email)
    

    mail to: email, subject: "Thanks For Signing Up"
  end
end
