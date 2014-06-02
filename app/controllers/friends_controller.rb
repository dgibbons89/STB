class FriendsController < ApplicationController
             
    def index   
        if params[:code]
            # acknowledge code and get access token from FB
            session[:access_token] = session[:oauth].get_access_token(params[:code])
        end 
 
        # auth established, now do a graph call:
        @api = Koala::Facebook::API.new(session[:access_token])
 
        begin
            @user_profile = @api.get_object("me")
        rescue Exception=>ex
            puts ex.message
            #if user is not logged in and an exception is caught, redirect to the page where logging in is requested
            redirect_to '/login' and return
        end
 
        respond_to do |format|
         format.html {   }    
        end
    end
     
    #########################################################
     
    def login
        session[:oauth] = Koala::Facebook::OAuth.new('675585185824524', 'aa5adc9f89aefb6240ad211b5519b209', 'www.stolobu.com' + '/')
        @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"friends")  
 
        redirect_to friends_path
    end
     
    #########################################################
end