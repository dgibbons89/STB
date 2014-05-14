class Picture < ActiveRecord::Base
	belongs_to :user
	has_many :votes
	

	

	has_attached_file :image, :styles => { :medium => "300x300>"}

	validates :zip, presence: true, numericality: { only_integer: true }
	validates :image, presence: true
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

	def self.search(query)
  		where("zip like ?", "%#{query}%") 
	end

	
end


