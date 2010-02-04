class Category < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :within => 2..255
  
  has_many :pictures
  has_many :movies
  has_many :story
  
end
