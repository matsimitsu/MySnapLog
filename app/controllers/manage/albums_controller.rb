class Manage::AlbumsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_album, :only => [:edit, :update, :ubb]
  def index
    @albums = current_user.albums
  end
  
  def edit
  end
  
  def ubb
    @photos = @album.photos
  end
  
  def update
    if @album.update_attributes(params[:album])
      flash[:notice] = "Album updated!"
      redirect_to manage_albums_path
    else
      render :action => :edit
    end
  end
  
  private
  
  def load_album
    @album = current_user.albums.find_by_slug(params[:id])
  end
end