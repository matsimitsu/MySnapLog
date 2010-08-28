class Manage::PhotosController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_event
  
  def index
    @photos = @event.photos
  end
  
  def create
    @photo = @event.photos.create(:image => swf_upload_data, :user_id => current_user.id, :source => 'upload')
    render :update do |page|
      page.insert_html :bottom, :photos, :partial => 'manage/photos/photo', :locals => { :photo => @photo }
    end
    
  end
  
  def stats
    @photo = @event.photos.find(params[:id])
  end
end