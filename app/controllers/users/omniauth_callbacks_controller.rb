class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

 def facebook 
unless auth.credentials.token.blank? 
current_user.create_facebook_access_token(
{
:access_token => auth.credentials.token, 
:email => auth.info.email, 
:political => auth.extra.raw_info.political, 
:religion => auth.extra.raw_info.religion, 
:uid => auth.uid
:friendlists => auth.extra.raw_info.friendlists
}
) if current_user.facebook_access_token.blank?

else
flash[:alert] = 'You need to permit the app to access your facebook credential'
end
redirect_to root_path
end
end