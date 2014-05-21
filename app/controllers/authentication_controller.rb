class AuthenticationsController < ApplicationController

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

  def fb_friends
	@user_fb_token = current_user.facebook_access_token

	unless @user_fb_token.blank?
		@fb_friends = FbGraph::User.me(@user_fb_token.access_token).friends
		@fb_friends = @fb_friends.sort_by { |fb_frnd| fb_frnd.raw_attributes['name']}
	end
end

	



end