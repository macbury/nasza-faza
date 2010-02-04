class SchoolsController < ApplicationController
  before_filter :login_required, :except => [:index, :show, :radar_chart]
	filter_resource_access
	
  # GET /schools
  # GET /schools.xml
  def index
    @schools = School.all

    @map = GoogleMap::Map.new
    @map.controls = [ :large, :menu_type, :overview ]
    
    @map.double_click_zoom = true
    @map.continuous_zoom = true
    @map.scroll_wheel_zoom = false
    
    @map.center = SKARZYSKO
    @map.zoom = 11
    
    @map.markers = []
    
    icon = GoogleMap::Icon.new(:width => 32, :height => 37, :image_url => '/images/markers/prison.png', :shadow_url => '', :map => @map, :anchor_y => 37, :anchor_x => 16, :info_anchor_x => 16, :info_anchor_y => 10 )
    
    @schools.each do |school|
      options = { :map => @map, 
                  :icon => icon,
                  :lat => school.lat, 
                  :lng => school.lng,
                  :dom_id => school.marker_id,
                  :html => render_to_string(:partial => school),
                  :marker_hover_text => "Szkoła o nazwie #{school.name}",
                  :open_infoWindow => false 
                }
      if admin?
        options[:draggable] = true
        #options[:dragstart] = "school_position_update"
        options[:dragend] = render_to_string(:partial => "/schools/drag_end.js.erb", :locals => { :school => school })
      end
      @map.markers << GoogleMap::Marker.new(options)
    end

    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @schools }
    end
  end
  
	filter_access_to :followed, :attribute_check => false
  def followed
    @schools = self.current_user.schools.all
    @stories = Story.all(:conditions => { :school_id.in => @schools.map(&:id) },:order => 'created_at DESC', :limit => 5)
    @pictures = Picture.all(:conditions => { :school_id.in => @schools.map(&:id) }, :order => 'created_at DESC', :limit => 5)

  end
  
  # GET /schools/1
  # GET /schools/1.xml
  def show
    @stories = @school.stories.all(:order => 'created_at DESC', :limit => 5)
    @pictures = @school.pictures.all(:order => 'created_at DESC', :limit => 5)
    @movies = @school.movies.all(:order => 'created_at DESC', :limit => 5)
  end

  # GET /schools/new
  # GET /schools/new.xml
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @school }
    end
  end

  # GET /schools/1/edit
  def edit
 
    render :action => "new"
  end

  # POST /schools
  # POST /schools.xml
  def create

    respond_to do |format|
      if @school.save
        flash[:notice] = 'School was successfully created.'
        format.html { redirect_to(@school) }
        format.xml  { render :xml => @school, :status => :created, :location => @school }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @school.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /schools/1
  # PUT /schools/1.xml
  def update

    respond_to do |format|
      if @school.update_attributes(params[:school])
        flash[:notice] = 'School was successfully updated.'
        format.html { redirect_to(@school) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @school.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def move
    @school.lat = params[:lat]
    @school.lng = params[:lng]
    @school.save
    
    render :nothing => true
  end
  
  def radar_chart
    school = School.find(params[:id])
    
    stats = []
    names = []
    
    Category.all.each do |category|
      names << category.name
      stats << school.stories.average(:rate, :conditions => { :category_id => category.id }) rescue 0
    end
    
    
    size = 280
    url = "http://chart.apis.google.com/chart?cht=r&chs=#{size}x#{size}&chd=t:#{stats.map(&:to_i).join(',')},#{stats[0]}&chco=FF9900&chls=2.0,4.0,0.0&chxt=x&chxl=0:|#{names.join('|')}&chm=B,FF990080,0,1.0,5.0|B,FF990080,1,1.0,5.0&chds=0,#{names.size-1}"
    
    respond_to do |format|
      format.png { redirect_to url }
    end
  end
  
  # DELETE /schools/1
  # DELETE /schools/1.xml
  def destroy
    @school.destroy

    respond_to do |format|
      format.html { redirect_to(schools_url) }
      format.xml  { head :ok }
    end
  end
end
