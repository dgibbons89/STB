module Koala
  module Facebook
    class OAuth
    	attr_reader :app_id, :app_secret, :oauth_callback_url

		def get_access_token(code, options = {})
			        # upstream methods will throw errors if needed
			if info = get_access_token_info(code, options)
					string = info["access_token"]
				end
			end
		end
	end
end


			 