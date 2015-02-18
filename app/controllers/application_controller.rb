class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  private
  def current_user
    User.find_by_id(session[:current_user_id])
  end
  helper_method :current_user

  def require_user
    unless current_user
      redirect_to frustrations_url,
      alert: "You are not signed in"
    end
  end
end