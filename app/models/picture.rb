class Picture < ActiveRecord::Base
	attr_accessor :image_file_name
	belongs_to :user
	has_attached_file :image, :styles => { :medium => "300x300>"}
validates :zip, presence: true
validates :image, presence: true
validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
end
