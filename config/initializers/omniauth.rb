OmniAuth.config.logger = Rails.logger



Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['675585185824524'], ENV['aa5adc9f89aefb6240ad211b5519b209'],
  			:scope => 'email,user_birthday,read_stream', :display => 'popup'
end