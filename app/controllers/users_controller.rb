class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create, :show]
  filter_access_to :index, :edit, :update, :admin, :normal

  def index
    @admins = User.all :conditions => { :admin => true }
  end
  
  def grow
    stats = User.count(:id, :conditions=> { :created_at.gte => Date.current.at_beginning_of_month }, :group => "YEAR (created_at),MONTH(created_at), DAY(created_at)", :order => "created_at")
    
    days = {}
    saldo = 0
    
    (1..Date.current.at_end_of_month.day).each do |d| 
      saldo += stats[d.to_s] rescue 0
      days[d] = saldo
      #saldo += days[d]
      #days[d] = saldo
    end

    days = days.sort{ |a,b| a[0].to_i <=> b[0].to_i }
    
    y_axis = days.map { |k,v| v.to_i }
    
    max = stats.map { |k,v| v }.max
    max = 10 if max.nil? || max < 10
    
    if max > 10_000
      steps = 10_000
    elsif max > 1000
      steps = 1000
    elsif max > 100
      steps = 100
    elsif max > 10
      steps = 10
    else
      steps = 1
    end
    
    respond_to do |format|
      format.png { redirect_to "http://chart.apis.google.com/chart?cht=lc&chs=500x200&chd=t:#{y_axis.join(',')}&chds=1,#{max}&chxt=x,y&chxr=0,1,#{days.size},1|1,1,#{max},#{steps}" }
    end
    
  end
  
  def new
    @user = User.new
  end
  
  def show
    user = User.find_by_login(params[:id])
    @schools = user.schools.all
    @stories = Story.all(:conditions => { :school_id.in => @schools.map(&:id) },:order => 'created_at DESC', :limit => 5)
    @pictures = Picture.all(:conditions => { :school_id.in => @schools.map(&:id) }, :order => 'created_at DESC', :limit => 5)
    @movies = Movie.all(:conditions => { :school_id.in => @schools.map(&:id) }, :order => 'created_at DESC', :limit => 5)
    
    respond_to do |format|
      format.rss
    end
  end
  
  def create
    @user = User.new(params[:user])
    if verify_recaptcha(:model => @user, :private_key => RECAPTCHA_PRIVATE_KEY ) && @user.save
      flash[:notice] = "Successfully created user."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def normal
    @user = User.find(params[:id])
    @user.admin = false
    @user.save
    flash[:notice] = "Admin zdegradowany do użytkownika"
    redirect_to users_path
  end
  
  def admin
    @user = User.login_like(params[:login]).first
    
    if @user.nil?
      flash[:error] = "Brak użytkwonika"
    else
      flash[:notice] = "Maru dodany jako admin!"
      @user.admin = true
      @user.save
    end
    
    redirect_to users_path
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
