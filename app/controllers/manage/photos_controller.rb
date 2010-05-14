class Manage::PhotosController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_event
  
  def index
    @photos = @event.photos
  end
  
  def create
    @photo = @event.photos.create(:image => swf_upload_data, :user_id => current_user.id)
    render :update do |page|
      page.insert_html :bottom, :photos, :partial => 'manage/photos/photo', :locals => { :photo => @photo }
    end
    
  end
  
  private
  
  def load_event
    @event = Event.find_by_slug(params[:event_id])
  end
end