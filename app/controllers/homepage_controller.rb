class HomepageController < ApplicationController
  
  def show
    @events = Event.recent.limited(10).all
  end
end