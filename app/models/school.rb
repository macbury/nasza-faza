class School < ActiveRecord::Base
  xss_terminate
  
  has_many :stories, :dependent => :destroy
  has_many :pictures, :dependent => :destroy
  has_many :movies, :dependent => :destroy
  
  has_many :followers, :dependent => :destroy
  has_many :users, :through => :followers
  
  validates_presence_of :name, :region, :locality, :street
  validates_length_of :name, :within => 3..100
  validates_uniqueness_of :name
  
  before_save :get_geoposition
  
  def full_adress
    "#{self.region} #{self.locality} #{self.street} #{self.postal_code}"
  end
  
  def marker_id
    "school_marker_#{self.id}"
  end
  
  def self.categories_name
    ['Fazy', 'Dziewczyny', 'Nauczyciele', 'Stan Szkoły']
  end
  
  def self.categories
    cat = []
    School.categories_name.each_with_index do |stan, index|
      cat << [stan, index]
    end
    
    cat
  end
  
  def recount_points
    #self.faza_stats = self.stories.average(:rate, :conditions => { :category_id => 0 }) || 0
    #self.dziewczyny_stats = self.stories.average(:rate, :conditions => { :category_id => 1 }) || 0
    #self.nauczyciele_stats = self.stories.average(:rate, :conditions => { :category_id => 2 }) || 0
    #self.stan_stats = self.stories.average(:rate, :conditions => { :category_id => 3 }) || 0
    #save
  end
  
  def latest_photo
    pictures.first(:order => 'created_at DESC') || Picture.new
  end
  
  protected
  
    def get_geoposition
      return unless region_changed? || street_changed? || locality_changed?
      
      geo = Geokit::Geocoders::MultiGeocoder.geocode("Polska #{self.full_adress}")
      
      if geo.lat.nil? || geo.lng.nil?
        errors.add_to_base("Niepoprawny adres!")
      else
        self.lat = geo.lat
        self.lng = geo.lng
      end
      
    end
  
end