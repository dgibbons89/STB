class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :zip
      t.attachment :video

      t.timestamps
    end
  end
end
