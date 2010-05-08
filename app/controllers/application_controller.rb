# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  
  filter_parameter_logging :password, :password_confirmation
  before_filter :load_user

  def load_user
    @user = User.find_by_slug(params[:user_id])
  end
end
