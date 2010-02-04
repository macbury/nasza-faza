class AddStatsToSchools < ActiveRecord::Migration
  def self.up
    add_column :schools, :dziewczyny_stats, :integer, :default => 0
    add_column :schools, :faza_stats, :integer, :default => 0
    add_column :schools, :nauczyciele_stats, :integer, :default => 0
    add_column :schools, :stan_stats, :integer, :default => 0
    
    add_column :stories, :category_id, :integer
  end

  def self.down
    remove_column :schools, :stan_stats
    remove_column :schools, :nauczyciele_stats
    remove_column :schools, :faza_stats
    remove_column :schools, :dziewczyny_stats
    
    remove_column :stories, :category_id, :integer
  end
end
