class StoriesController < ApplicationController
  before_filter :get_school
  before_filter :login_required, :except => [:index, :show]
  
  include ActionView::Helpers::TextHelper
  
  def index
    conditions = {}
    conditions[:category_id] = params[:category].to_i if params[:category]
    
    @stories =  @school.stories.search(conditions).paginate :page => params[:page], :per_page => 5, :order => 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stories }
    end
  end

  # GET /stories/1
  # GET /stories/1.xml
  def show
    @story = @school.stories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @story }
    end
  end
  
  def rate
    @story = @school.stories.find(params[:id])
    rate = params[:rate].to_i
    if rate && (0..Rate.names.size-1).include?(rate)
      self.current_user.rate(@story, rate)
    end
    
    respond_to do |format|
      format.html { redirect_to school_story_path(@school, @story) }
      format.js
    end
  end
  
  # GET /stories/new
  # GET /stories/new.xml
  def new
    @story = Story.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @story }
    end
  end

  # GET /stories/1/edit
  def edit
    @story = self.current_user.stories.find(params[:id])
    render :action => "new"
  end

  # POST /stories
  # POST /stories.xml
  def create
    @story = self.current_user.stories.new(params[:story])
    @story.school = @school
    
    respond_to do |format|
      if @story.save
        Blip.create :body => "#{truncate(@story.body, :length => 100)} - #{school_story_url(@school, @story)}"
        flash[:notice] = 'Story was successfully created.'
        format.html { redirect_to([@school,@story]) }
        format.xml  { render :xml => @story, :status => :created, :location => @story }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stories/1
  # PUT /stories/1.xml
  def update
    @story = self.current_user.stories.find(params[:id])
    @story.school = @school
    
    respond_to do |format|
      if @story.update_attributes(params[:story])
        flash[:notice] = 'Story was successfully updated.'
        format.html { redirect_to([@school,@story]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @story.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1
  # DELETE /stories/1.xml
  def destroy
    @story = self.current_user.stories.find(params[:id])
    @story.destroy

    respond_to do |format|
      format.html { redirect_to(school_stories_url(@school)) }
      format.xml  { head :ok }
    end
  end

end
