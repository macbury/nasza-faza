class Picture < ActiveRecord::Base
  has_attached_file :image, 
          :styles => { :original => "640x480>", :medium => "300x200>", :thumb => "120x120>" },
          :url  => "/pictures/:style/:id.:extension",
          :path => ":rails_root/public/pictures/:style/:id.:extension"
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png'], :message => "nieprawidłowy format pliku"
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_presence :image
  xss_terminate
  
  validates_presence_of :name
  
  attr_accessible :image, :category_id, :name
  
  has_many :rates, :as => :ratable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  belongs_to :category
  belongs_to :user
  belongs_to :school
  
  def url(size=nil)
    image.url(size)
  end
  
  def rate_to_s
    return "#{Rate.names[self.rate.round]}(#{self.rate})"
  end
  
  def recount_points
    self.rate = self.rates.average(:point)
    save
  end
  
  def category_name
    School.categories_name[self.category_id] rescue ""
  end
  
end
