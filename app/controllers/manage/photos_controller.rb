class Manage::PhotosController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_album
  
  def index
    @photos = @album.photos
  end
  
  def create
    @photo = @album.photos.create(:image => swf_upload_data) # here you can use your favourite plugin to work with attachments
    render :update do |page|
      page.insert_html :bottom, :photos, :partial => 'manage/photos/photo', :locals => { :photo => @photo }
    end
    
  end
  
  private
  
  def load_album
    @album = Album.find_by_slug(params[:album_id])
  end
end