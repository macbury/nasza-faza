class CommentsController < ApplicationController
  before_filter :login_required, :find_commentable
  
  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = self.current_user
    if @comment.save
      flash[:notice] = "Dodano komentarz"
    else
      flash[:error] = "Nie można dodać komentarza"
    end
    
    respond_to do |format|
      format.html { redirect_to_commentable(@commentable) }
      format.js
    end
  end
  
  def destroy
    @comment = self.current_user.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to root_url
  end
  
  def update
    @comment = self.current_user.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
  
  def edit
    @comment = self.current_user.comments.find(params[:id])
  end
end
