class AddColumnToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :video_id, :integer
  end
end
