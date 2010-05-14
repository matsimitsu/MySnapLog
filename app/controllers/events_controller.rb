class EventsController < ApplicationController
  
  find_parent_resource :field => :slug
  
  def index
    @events = @user.events
  end

  def show
    @event = Event.find_by_slug(params[:id])
    @activities = @event.activities.paginate(:order => 'created_at DESC', :page => params[:page])
  end
end