class Video < ActiveRecord::Base

	belongs_to :user
	has_many :votes
	has_attached_file :video, :styles => {
    :medium => { :geometry => "640x480", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
    :large => { :geometry => "1024x576", :format => 'flv', :convert_options => {:output => {:ar => 44100}} },
  }, :processors => [:ffmpeg], :swallow_stderr => false

	validates :zip, presence: true, numericality: { only_integer: true }
	validates :video, presence: true
	validates_attachment :video, content_type: { content_type: ["video/mp4"] }
	
  	#after_create :convert_in_flv, :set_new_filename

	def self.search(query)
  		where("zip like ?", "%#{query}%") 
	end
	#def convert_in_flv
  	#	flv = File.join(File.dirname(video.path), "#{id}.flv")
 	#	system("ffmpeg -i #{video.path} -ar 22050 -ab 32 -s 480x360 -vcodec flv -r 25 -qscale 8 -f flv -y #{flv}")
 	#end
	#def set_new_filename
	 # update_attribute(:video_file_name, "#{id}.flv")
	#end
  
end
