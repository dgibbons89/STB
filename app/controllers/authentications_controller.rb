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
  


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
	



end