OmniAuth.config.logger = Rails.logger



Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['678699708846405'], ENV['aa5adc9f89aefb6240ad211b5519b20']
end