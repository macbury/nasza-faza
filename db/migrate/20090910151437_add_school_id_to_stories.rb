class AddSchoolIdToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :school_id, :integer
  end

  def self.down
    remove_column :stories, :school_id
  end
end
