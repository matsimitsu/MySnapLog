ActionController::Routing::Routes.draw do |map|
  map.devise_for :users
  
  map.resources :users
  
  map.resources :events, :member => { :join => [:get, :post] } do |event|
    event.resources :photos, :member => { :like => :get }, :collection => [:grid, :medium, :large] do |photo|
      photo.resources :comments, :only => [:create]
    end
  end
  
  map.namespace :manage do |manage|
    manage.resource :dashboard
    manage.resources :events, :member => { :ubb => :get } do |event|
      event.resources :photos
    end
    manage.resource :profile, :collection => { :edit => :get, :update => :put }
  end

  # root
  map.resource :user_session
  map.root :controller => :homepage, :action => :show
end