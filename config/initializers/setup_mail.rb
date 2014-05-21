ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "http://safe-brook-9428.herokuapp.com/",
  :user_name            => "dgibbons89@gmail.com",
  :password             => "bbsyDV6W",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
ActionMailer::Base.default_url_options[:host] = "http://safe-brook-9428.herokuapp.com"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?