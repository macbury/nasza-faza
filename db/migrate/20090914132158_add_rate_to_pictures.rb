class AddRateToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :rate, :float, :default => 0.0
  end

  def self.down
    remove_column :pictures, :rate
  end
end
