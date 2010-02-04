class FollowersController < ApplicationController
  before_filter :login_required
  before_filter :get_school
  
  def index
    redirect_to root_path
  end
  
  def create
    @follower = self.current_user.followers.find_or_create_by_school_id(@school.id)
    flash[:notice] = "Zaczynasz obserwować tą szkołę" if @follower.new_record?
    
    respond_to do |format|
      format.html { redirect_to @school }
      format.js
    end
  end
  
  def destroy
    @follower = self.current_user.followers.find(params[:id])
    @follower.destroy
    flash[:notice] = "Przestajesz obserwować tą szkołę..."
    
    respond_to do |format|
      format.html { redirect_to @school }
      format.js
    end
    
  end
end
