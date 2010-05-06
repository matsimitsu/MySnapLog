ActionController::Routing::Routes.draw do |map|
  map.devise_for :users

  map.namespace :manage do |manage|
    manage.resources :albums do |album|
      album.resources :photos
    end
  end

  # root
  map.root :controller => :user, :action => :sign_in
  map.resource :user_session
  map.root :controller => "user_sessions", :action => "new"
end