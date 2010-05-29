class Manage::FlickrController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_event, :only => [:index, :import]
  
  def index
    if current_user.flickr_token.present?
     begin
        @flickr_user = Fleakr.user_for_token(current_user.flickr_token)
        @sets = @flickr_user.sets
      rescue Fleakr::ApiError
        @auth_url = Fleakr.authorization_url
      end
    else
      @auth_url = Fleakr.authorization_url
    end
  end
  
  def return_url
    if params[:frob]
      token = Fleakr.token_from_frob(params[:frob])
      current_user.set_flickr_token(token.value)
      redirect_to root_path
    end
  end
  
  def import
    if params[:id]
      Navvy::Job.enqueue(FlickrImporter::Importer, :set, current_user, @event, params[:id])
      flash[:notice] = 'Added import to queue'
    end
    redirect_to index_manage_event_flickr_path(@event)
  end
end


