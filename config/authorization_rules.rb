authorization do
  role :admin do
		includes :guest

    has_permission_on :categories, :to => [:manage, :read]
		has_permission_on :users, :to => [:manage, :read, :admin, :normal]
		has_permission_on :schools, :to => [:manage, :read, :move]
  end
  
  role :author do
    includes :guest
		has_permission_on :schools, :to => :followed
  end

  role :guest do
    has_permission_on :users, :to => :create
		has_permission_on :schools, :to => :read
  end
end

privileges do
	privilege :manage, :includes => [:create, :read, :update, :delete]
	privilege :read, :includes => [:index, :show]
	privilege :create, :includes => :new
	privilege :update, :includes => :edit
	privilege :delete, :includes => :destroy
end