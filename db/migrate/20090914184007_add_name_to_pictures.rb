class AddNameToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :name, :string
  end

  def self.down
    remove_column :pictures, :name
  end
end
