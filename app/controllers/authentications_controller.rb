class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!
   def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
    end
  


  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

   def facebook
 # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  else
    session["devise.facebook_data"] = request.env["omniauth.auth"]
    redirect_to root_path
  end
end

def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
	



end