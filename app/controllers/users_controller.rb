class UsersController < ApplicationController
  before_filter :require_login

  def fields
    @fields = current_user.fields
    respond_to do |format|
      format.html { render "fields/index"}
      format.json { render json: @fields }
    end
  end

end
