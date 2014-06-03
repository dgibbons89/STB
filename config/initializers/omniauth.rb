require 'omniauth/oauth'
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '675585185824524', 'aa5adc9f89aefb6240ad211b5519b209', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
end