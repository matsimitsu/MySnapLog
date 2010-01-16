ActionController::Routing::Routes.draw do |map|
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :sites
  map.resources :posts, :collection => [:batch, :upload_image_block]
  map.resource :user_session
  map.root :controller => "user_sessions", :action => "new"
end
