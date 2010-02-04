class MoviesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :get_school
  
  # GET /movies
  # GET /movies.xml
  def index
    @movies = @school.movies.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = @school.movies.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = @school.movies.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  def rate
    @movie = @school.movies.find(params[:id])
    rate = params[:rate].to_i
    if rate && (0..Rate.names.size-1).include?(rate)
      self.current_user.rate(@movie, rate)
    end
    
    respond_to do |format|
      format.html { redirect_to school_movie_path(@school, @movie) }
      format.js
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = self.current_user.movies.find(params[:id])
    render :action => "new"
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie = @school.movies.new(params[:movie])
    @movie.user = self.current_user
    respond_to do |format|
      if @movie.save
        Blip.create :body => "#{@movie.name} - #{school_movie_url(@school, @movie)}"
        flash[:notice] = 'Film został dodany.'
        format.html { redirect_to([@school,@movie]) }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = self.current_user.movies.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        flash[:notice] = 'Movie was successfully updated.'
        format.html { redirect_to([@school,@movie]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie = self.current_user.movies.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to(school_movies_path(@school)) }
      format.xml  { head :ok }
    end
  end
end
