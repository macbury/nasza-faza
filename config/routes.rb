ActionController::Routing::Routes.draw do |map|
  map.resources :categories

  map.resources :schools, :member => { :move => :post, :radar_chart => :get }, :collection => { :followed => :get} do |school|
    school.resources :stories, :member => { :rate => :get }, :has_many => :comments
    school.resources :pictures, :member => { :rate => :get }, :has_many => :comments
    school.resources :followers
    school.resources :movies, :member => { :rate => :get }, :has_many => :comments
  end
  
  map.resources :user_sessions
  map.resources :users, :member => { :normal => :get }, :collection => { :admin => :get, :grow => :get }
  
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  map.register '/register', :controller => 'users', :action => 'new'

  map.root :controller => "schools"
  
  map.connect '/pictures/:style/:id.:format', :controller => 'pictures', :action => 'serve_tmp_files'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
