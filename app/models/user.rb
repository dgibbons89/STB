class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  

  has_many :pictures, dependent: :destroy
  has_many :authentications, :dependent => :delete_all
  
  def apply_omniauth(auth)
  # In previous omniauth, 'user_info' was used in place of 'raw_info'
  self.email = auth['extra']['raw_info']['email']
  # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
  authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
end

  def self.find_or_create_by_facebook(data)
    self.find_or_create_by_facebook_id(data['extra']['raw_info']['id'], :facebook_token => data['credentials']['token'])
  end

  validates :name, presence: true
end
