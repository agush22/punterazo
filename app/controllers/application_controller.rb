class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def require_login
    unless current_user
      flash[:error] = "Necesitas estar loggeado para acceder"
      redirect_to new_user_session_path
    end
  end

end
