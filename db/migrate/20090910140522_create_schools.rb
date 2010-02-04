class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.string :name
      t.string :street
      t.string :locality
      t.string :region
      t.integer :postal_code

      t.timestamps
    end
  end

  def self.down
    drop_table :schools
  end
end
