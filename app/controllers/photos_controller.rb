require 'digest/sha1'

class PhotosController < ApplicationController
  
  find_parent_resource :field => :slug
  before_filter :load_photo, :only => [:like, :show]
  helper_method :user_hash
  
  def index
    @photos = @album.photos.paginate(:order => 'created_at ASC', :page => params[:page], :per_page => @album.photos_per_page)
  end
  
  def show
    
  end
  
  def like
    @photo.like(user_hash)
    @photo.reload
  end
  
  private
  
  def user_hash
    Digest::SHA1.hexdigest("#{request.env['HTTP_USER_AGENT']}_#{request.env['REMOTE_ADDR']}")
  end
  
  def load_photo
    @photo = @album.photos.find(params[:id])
  end
end