class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private
  def require_login
    unless current_user
      flash[:error] = "Necesitas estar loggeado para acceder"
      redirect_to new_user_session_path
    end
  end

end
