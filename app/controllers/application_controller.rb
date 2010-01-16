# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  before_filter :require_login, :set_current_site
  layout proc { |controller| controller.in_manage? ? 'manage' : 'application' }
  
  def in_manage? 
    request.path.starts_with?('/manage')
  end
  
  
  private
  
  def current_host
    request.domain(3)
  end
    
  def set_current_site
    return @current_site if @current_site
    
    url_name = current_host.split('.').first
    unless url_name.blank?
      @current_site = Site.find_by_domain(url_name)
    else
      nil
    end
  end
  
  
  def require_login
    require_user if in_manage?
  end
  
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to account_url
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
