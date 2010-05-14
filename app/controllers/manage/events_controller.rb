class Manage::EventsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :load_event, :only => [:edit, :update, :ubb]
  def index
    @events = current_user.managed_events
  end
  
  def new
    @event = Event.new
  end
  
  def create
    if current_user.managed_events.create(params[:event])
      flash[:notice] = "Event updated!"
      redirect_to manage_events_path
    else
      render :action => :edit
    end
  end
  
  def edit
  end
  
  def ubb
    @photos = @event.photos
  end
  
  def update
    if @event.update_attributes(params[:event])
      flash[:notice] = "Event updated!"
      redirect_to manage_events_path
    else
      render :action => :edit
    end
  end
  
  private
  
  def load_event
    @event = current_user.managed_events.find_by_slug(params[:id])
  end
end