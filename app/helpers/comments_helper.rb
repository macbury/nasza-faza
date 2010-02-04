module CommentsHelper
  def form_for_commentable(commentable, comment, &block)
    if commentable.respond_to?(:school_id)
      return form_for([commentable.school, commentable, comment], &block)
    else
      return form_for([commentable, comment], &block)
    end
  end
end
