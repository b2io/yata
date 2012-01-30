class SessionsController < ApplicationController
  def new
  end

  def create
    session[:user_id] = User.from_omniauth(env["omniauth.auth"]).id
    redirect_to todo_path, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end
