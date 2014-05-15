Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook

provider :facebook, "675585185824524", "aa5adc9f89aefb6240ad211b5519b209", 
  {:scope => 'email, offline_access', :display => "popup", :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}} 
end
