class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!
   def create
    @user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
    redirect_to root_url
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end




	



end