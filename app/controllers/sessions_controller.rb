class SessionsController < ApplicationController
  def new
    redirect_to todo_path if current_user
  end

  def create
    auth = env["omniauth.auth"]
    unless @auth = Authorization.find_from_hash(auth)
      @auth = Authorization.create_from_hash(auth, current_user)
    end
    self.current_user = @auth.user
    redirect_to todo_path, flash: { success: "Signed in!" }
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash: { success: "Signed out." }
  end

  def failure
    redirect_to root_url, flash: { error: "Authentication failed, please try again." }
  end
end
