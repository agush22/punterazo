class UsersController < ApplicationController
before_filter :require_login

  def fields
    @fields = current_user.fields
    respond_to do |format|
      format.html { render "fields/index"}
      format.json { render json: @fields }
    end
  end

private
  def require_login
    unless current_user
      flash[:error] = "Necesitas estar loggeado para acceder"
      redirect_to new_user_session_path
    end
  end
end
