class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize

  protected

  def authorize
    unless current_user
      redirect_to root_path, flash: { error: "Unauthorized access." }
      false
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  helper_method :current_user, :signed_in?
end
