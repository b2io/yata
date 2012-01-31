class SessionsController < ApplicationController
  def new
    redirect_to todo_path if current_user
  end

  def create
    session[:user_id] = User.from_omniauth(env["omniauth.auth"]).id
    redirect_to todo_path, flash: { info: "Signed in!" }
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash: { info: "Signed out." }
  end

  def failure
    redirect_to root_url, flash: { error: "Authentication failed, please try again." }
  end
end
