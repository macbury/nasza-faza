class Movie < ActiveRecord::Base
  xss_terminate
  
  validates_presence_of :name
  validates_length_of :name, :within => 3..255
  
  belongs_to :user
  belongs_to :school
  belongs_to :category
  
  has_many :rates, :as => :ratable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  attr_accessible :name, :category_id, :clip
  
  def rate_to_s
    return "#{Rate.names[self.rate.round]}(#{self.rate})"
  end
  
  def recount_points
    self.rate = self.rates.average(:point)
    save
  end
  
end
