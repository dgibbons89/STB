class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :picture_id

      t.timestamps
    end
  end
end
