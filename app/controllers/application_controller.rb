class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def must_be_admin
    return redirect_to subsidiary_path(current_user.subsidiary) unless current_user.admin?
  end
end
