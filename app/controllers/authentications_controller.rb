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