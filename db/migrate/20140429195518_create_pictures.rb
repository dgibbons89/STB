class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :zip
      t.attachment :image

      t.timestamps
    end
  end
  
  def self.down
  	drop_attached_file :pictures, :image
	end
end
