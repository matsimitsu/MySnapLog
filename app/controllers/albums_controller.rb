class AlbumsController < ApplicationController
  
  find_parent_resource :field => :slug
  
  def index
    @albums = @user.albums
  end


end