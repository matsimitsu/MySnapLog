class EventsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show, :index, :create_join_request]
  before_filter :load_event, :only => [:show, :join, :create_join_request]
  
  def index
    @events = @user.events
  end

  def show
    @activities = @event.activities.paginate(:order => 'created_at DESC', :page => params[:page])
  end
  
  def join
    unless @event.join_request_required
      @event.add_user(current_user)
      redirect_to event_path(@event)
    end
  end
  
  def create_join_request
    @join_request = JoinRequest.new(params[:join_request])
    @event.create_join_request(@join_request)
    flash[:notice] = 'We have sent your request.'
    redirect_to event_path(@event)
  end
  
  private
  def load_event
    @event = Event.find_by_slug(params[:id])
  end
end