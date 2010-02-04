class CreateRates < ActiveRecord::Migration
  def self.up
    create_table :rates do |t|
      t.string :ratable_type
      t.integer :ratable_id
      t.integer :point
      t.integer :user_id

      t.timestamps
    end
    
    add_column :stories, :rate, :float, :default => 0
  end

  def self.down
    drop_table :rates
    remove_column :stories, :rate
  end
end
