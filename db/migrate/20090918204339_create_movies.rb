class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :name
      t.integer :status
      t.float :rate, :default => 0.0
      t.integer :user_id
      t.integer :school_id
      t.integer :category_id
      
      t.timestamps
    end

  end

  def self.down
    drop_table :movies
  end
end
