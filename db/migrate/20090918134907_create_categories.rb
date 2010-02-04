class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end
    
    ['Fazy', 'Dziewczyny', 'Nauczyciele', 'Stan Szkoły'].each do |name|
      Category.create( :name => name )
    end
  end

  def self.down
    drop_table :categories
  end
end
