class UsersController < ApplicationController
  
  before_filter :load_user
  
  def show
    @activities = @user.activities.paginate(:order => 'id DESC', :page => params[:page])
  end
  
  def load_user
    @user ||= User.find_by_slug(params[:id])
  end
end
