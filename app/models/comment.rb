class Comment < ActiveRecord::Base
  xss_terminate 
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  
  validates_presence_of :body
  validates_length_of :body, :within => 3..1024
  
  attr_accessible :body
  
  after_create :send_notifications
  
  protected

		def send_notifications
	    users_id = commentable.comments.all(:select => 'user_id', :conditions => { :user_id.not => self.user_id }, :group => 'user_id').map(&:user_id)

	    users_id = [] if users_id.nil?

	    users_id << commentable.user_id if self.user_id != commentable.user_id

	    users = User.all(:conditions => { :id.in => users_id } )

	    users.each do |user|
	      Notifier.deliver_comment(comment, user)
	    end

	  end
end
