ActionController::Routing::Routes.draw do |map|
  map.resource :account, :controller => "users"
  map.namespace :manage do |manage|
    manage.resources :users
    manage.resources :sites 
    manage.resources :posts, :collection => [:upload_image_block] do |post|
      post.resources :comments
    end
  end
  map.resource :user_session
  map.root :controller => "user_sessions", :action => "new"
end