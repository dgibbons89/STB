class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

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
def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

end