class Picture < ActiveRecord::Base
	attr_accessor  :image_file_name, :image_content_type
	belongs_to :user
	has_attached_file :image, :styles => { :large => "300x300>"}
validates :zip, presence: true, numericality: { only_integer: true }
validates :image, presence: true
validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
end
