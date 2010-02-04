class PicturesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :get_school
  
  def index
    @pictures = @school.pictures.all
  end
  
  def new
    @picture = Picture.new
  end
  
  def create
    @picture = @school.pictures.new(params[:picture])
    @picture.user = self.current_user
    
    if @picture.save
      flash[:notice] = "Dodano fotkę!"
      redirect_to [@school, @picture]
    else
      flash[:error] = "Nie można dodać pliku!"
      render :action => "new"
    end
  end
  
  def rate
    @picture = @school.pictures.find(params[:id])
    rate = params[:rate].to_i
    if rate && (0..Rate.names.size-1).include?(rate)
      self.current_user.rate(@picture, rate)
    end
    
    respond_to do |format|
      format.html { redirect_to [@school, @picture] }
      format.js
    end
  end
  
  def destroy
    @picture = @school.pictures.find(params[:id])
    
    @picture.destroy
    flash[:notice] = "Successfully destroyed pictures."
    redirect_to school_pictures_path(@school)
  end
  
  def show
    @picture = @school.pictures.find(params[:id])
  end
  
end
