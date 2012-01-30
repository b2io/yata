class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def authorize
    unless current_user
      flash[:error] = "Unauthorized access."
      redirect_to root_path
      false
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
