ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "stolobu.com",
  :user_name            => "DG",
  :password             => "secret",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "stolobu.com"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?