class User < ActiveRecord::Base
  xss_terminate
  acts_as_authentic
  
  validates_acceptance_of :regulamin, :on => :create
  
  attr_accessor :regulamin
  attr_protected :admin
  
  has_many :stories, :dependent => :destroy
  has_many :rates, :dependent => :destroy
  has_many :pictures, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :movies, :dependent => :destroy
  
  has_many :followers, :dependent => :destroy
  has_many :schools, :through => :followers
  
	def role_symbols
    roles = [:author]
		roles << :admin if admin?
		return roles
  end

  def admin?
    self.admin
  end
  
  def own?(object)
    object.respond_to?(:user_id) && (object.user_id == self.id)
  end
  
  def follow?(object)
    !follower(object).nil?
  end
  
  def follower(object)
    object.followers.find_by_user_id(self.id)
  end
  
  def rate(object,points)
    rate = object.rates.find_or_initialize_by_user_id(self.id)
    rate.point = points
    rate.save
    
    object.recount_points
  end
  
end