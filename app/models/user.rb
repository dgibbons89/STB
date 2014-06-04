class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  

  has_many :pictures, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :authentications, :dependent => :delete_all
  has_one :facebook_oauth_token
  has_one :friendlist
  
  
  

 


  def apply_omniauth(auth)
  # In previous omniauth, 'user_info' was used in place of 'raw_info'
  self.email = auth['extra']['raw_info']['email']
  # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
  authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
end

  def self.find_or_create_by_facebook(data)
    self.find_or_create_by_facebook_id(data['extra']['raw_info']['id'], :facebook_token => data['credentials']['token'])
  end
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
  data = access_token.extra.raw_info
  if data == "false"
    self.new
  elsif user = self.find_by_email(data.email)
    user
  else # Create a user with a stub password. 
    self.create!(:email => data.email, :password => Devise.friendly_token[0,20]) 
  end
end

  

 def friend_invite
 @friends = current_user.facebook.get_connections("me")   
end

  def self.create_with_omniauth(auth)  
    create! do |user|
      user.first_name = auth["user_info"]["first_name"]
      user.last_name = auth["user_info"]["last_name"]
      user.email = auth["user_info"]["email"]
      user.fb_uid = auth["uid"]
      user.fb_token = auth["credentials"]["token"]
    end
  end

  
  validates :name, presence: true
end
