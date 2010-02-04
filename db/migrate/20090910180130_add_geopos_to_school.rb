class AddGeoposToSchool < ActiveRecord::Migration
  def self.up
    add_column :schools, :lat, :float
    add_column :schools, :lng, :float
  end

  def self.down
    remove_column :schools, :lng
    remove_column :schools, :lat
  end
end
