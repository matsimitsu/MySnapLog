class Manage::DashboardsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @activities = current_user.activities.paginate(:order => 'id DESC', :page => params[:page])
  end
end