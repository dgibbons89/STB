class AddPersonToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :person, :string
  end
end
