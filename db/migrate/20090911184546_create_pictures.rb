class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.integer :school_id
      t.integer :user_id
      t.integer :category_id
      t.timestamps
    end
    
    add_column :pictures, :image_file_name,    :string
    add_column :pictures, :image_content_type, :string
    add_column :pictures, :image_file_size,    :integer
    add_column :pictures, :image_updated_at,   :datetime
  end
  
  def self.down
    drop_table :pictures
  end
end
