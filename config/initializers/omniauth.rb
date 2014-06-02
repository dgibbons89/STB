Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook , '675585185824524', 'aa5adc9f89aefb6240ad211b5519b209', 
       :scope => 'email, offline_access, user_friends, read_friendlists', :display => "popup"


                      
                      # friends_activities,friends_birthday,friends_education_history,friends_events,
                      # friends_groups,friends_hometown,friends_interests,friends_likes,friends_location,
                      # friends_photo_video_tags,friends_photos,friends_relationships,
                      # friends_relationship_details,friends_religion_politics,friends_status,
                      # friends_work_history
                      
                      # user_relationships, user_relationship_details,
                      # user_photo_video_tags,user_photos,
                      # publish_checkins,manage_pages,
                      # create_event,rsvp_event,sms,read_friendlists,read_insights,read_mailbox,
                      # read_requests,read_stream,xmpp_login,ads_management,
                      # user_checkins,user_videos,user_website, user_notes,user_online_presence,user_address,user_mobile_phone
                      # friends_notes,friends_online_presence, friends_videos,friends_website, manage_friendlists,friends_checkins
                      
                      #Adding, :iframe => true allows a Facebook App to redirect out of Facebook for authentication
end