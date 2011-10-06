class ApplicationController < ActionController::Base
  include ControllerAuthentication
  
  protect_from_forgery
  check_authorization
  
  helper_method :current_user_session, :current_user
  
  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      render 'shared/access_denied', :alert => exception.message
    else
      redirect_to login_url, :alert => exception.message
    end
  end
  
  protected
  
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
end
