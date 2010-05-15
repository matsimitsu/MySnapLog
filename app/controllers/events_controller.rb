class EventsController < ApplicationController
  
  before_filter :load_event, :only => [:show, :join]
  def index
    @events = @user.events
  end

  def show
    @activities = @event.activities.paginate(:order => 'created_at DESC', :page => params[:page])
  end
  
  def join
    
  end
  
  private
  def load_event
    @event = Event.find_by_slug(params[:id])
  end
end