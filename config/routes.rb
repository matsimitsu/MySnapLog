ActionController::Routing::Routes.draw do |map|
  map.devise_for :users
  
  map.resources :users do |user|
    user.resources :albums do |album|
      album.resources :photos, :member => { :like => :get } do |photo|
        photo.resources :comments, :only => [:create]
      end
    end
  end
  
  map.namespace :manage do |manage|
    manage.resources :albums, :member => { :ubb => :get } do |album|
      album.resources :photos
    end
    manage.resource :profile, :collection => { :edit => :get, :update => :put }
  end

  # root
  map.resource :user_session
  map.root :controller => :homepage, :action => :show
end