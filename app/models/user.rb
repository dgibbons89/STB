class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  

  has_many :pictures, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :authentications, :dependent => :delete_all
  has_many :friends
  

 
  
  
  
  validates :name, presence: true

 


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
     where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
  rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil # or consider a custom null object
  end


  def friends_count
    facebook { |fb| fb.get_connection("me", "friends").size }
  end

  def friends
    @friends ||= facebook { |fb| fb.get_connections("me", "friends", "fields"=>"name,birthday") }
  end

  

  def friends_birthday
    birthdays = Array.new(13) # [0] is not used
    friends.each do |friend|
      if friend["birthday"].present?
        birthday = friend["birthday"].split('/')
        month_i = birthday[0].to_i # [1]=Jan,[2]=Feb,...,[12]=Dec
        birthdays[month_i] ||= Array.new(32) # [0] is not used
        day_i = birthday[1].to_i # [1]=1,[2]=2,...,[31]=31
        birthdays[month_i][day_i] ||= Array.new
        birthdays[month_i][day_i] << friend
      end
    end
    birthdays
  end

  private

  def parse_birthday(birthday_str)
    if birthday_str.present?
      birthday_str = birthday_str.split('/')
      birthday = Date.strptime("#{birthday_str[0]}/#{birthday_str[1]}/#{Date.current.year}", '%m/%d/%Y') if birthday_str[0].present? && birthday_str[1].present?
    end
    birthday || nil
  end




 
end

  
  

