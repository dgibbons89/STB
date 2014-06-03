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

    def fb_friends
  	@user_fb_token = User.facebook_access_token

  	unless @user_fb_token.blank?
  		@fb_friends = FbGraph::User.me(@user_fb_token.access_token).friends
  		@fb_friends = @fb_friends.sort_by { |fb_frnd| fb_frnd.raw_attributes['name']}
  	end
  end

  def index
  unless current_user.facebook_oauth_setting
        @oauth = Koala::Facebook::OAuth.new("675585185824524", "aa5adc9f89aefb6240ad211b5519b209", "http://#{request.host}:#{request.port}/callback")
        session["oauth_obj"] = @oauth
        redirect_to @oauth.url_for_oauth_code
    else
        redirect_to "/facebook_profile"
    end
end
  def callback
  unless current_user.facebook_oauth_setting
        @oauth = session["oauth_obj"]
        FacebookOauthSetting.create({:access_token => @oauth.get_access_token_info(params[:code]), :user_id => current_user.id})
        redirect_to "/facebook_profile"
    else
        redirect_to "/"
    end
end

def facebook_profile
  if current_user.facebook_oauth_setting
        @graph = Koala::Facebook::API.new(current_user.facebook_oauth_setting.access_token)
        @friends = @graph.get_connections("me", "friends")
    else
        redirect_to "/"
    end
end
	



end