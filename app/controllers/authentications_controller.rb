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
  session[:oauth] = Koala::Facebook::OAuth.new("675585185824524", "aa5adc9f89aefb6240ad211b5519b209", "www.stolobu.com" + '/authentications/callback')
        @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"email, friends")  
    puts session.to_s + "<<< session"

    respond_to do |format|
       format.html {  }
     end
  end
  def callback
    if params[:code]
      # acknowledge code and get access token from FB
      session[:access_token] = session[:oauth].get_access_token(params[:code])
    end   

     # auth established, now do a graph call:

    @api = Koala::Facebook::API.new(session[:access_token])
    begin
      @graph_data = @api.get_object("/me/statuses", "fields"=>"message")
    rescue Exception=>ex
      puts ex.message
    end

  
    respond_to do |format|
     format.html {   }       
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