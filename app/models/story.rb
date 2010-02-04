class Story < ActiveRecord::Base
  xss_terminate
  
  validates_presence_of :body
  validates_length_of :body, :within => 3..2024
  #validates_exclusion_of :category_id, :in => School.categories.map { |element| element[1] }
  
  belongs_to :school
  belongs_to :user
  belongs_to :category
  
  has_many :rates, :as => :ratable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  attr_accessible :body, :category_id
  
  def recount_points
    self.rate = self.rates.average(:point)
    save
  end
  
  def name
    self.body
  end
  
  def category_name
    School.categories_name[self.category_id]
  end
  
  def rate_to_s
    return "#{Rate.names[self.rate.round]}(#{self.rate})"
  end
  
end
