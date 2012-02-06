class SessionsController < ApplicationController
  def new
    redirect_to todo_path if current_user
  end

  def create
    # Find/Create the authorization:

    auth = env["omniauth.auth"]

    # Try and find the authorization
    @auth = Authorization.find_from_hash(auth)

    # If there's a current-user:
    if current_user
      message = {}

      # If we found an authorization:
      if @auth
        if @auth.user.id == current_user.id
          message = { info: "That login is already linked to this YATA account." }
        else
          # TODO (DM): Implement account merges.
          message = { error: "That login is linked to another YATA account." }
        end
      # Otherwise, we haven't found an existing authorization:
      else
        # Create a new authorization linked to this user.
        @auth = Authorization.create_from_hash(auth, current_user)
        message = { success: "Successfully linked that login to your YATA account." }
      end

      # Send the user back to the 'profile/#/accounts' page.
      redirect_to profile_path + "#/accounts", flash: message

    # Otherwise, there's no current-user:
    else
      # If we weren't able to find an existing authorization: create one.
      unless @auth
        @auth = Authorization.create_from_hash(auth)
      end

      # Set the current user.
      self.current_user = @auth.user

      # Send the user to the 'todos' page.
      redirect_to todo_path, flash: { success: "Signed in!" }

    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_url, flash: { success: "Signed out." }
  end

  def failure
    redirect_to root_url, flash: { error: "Authentication failed, please try again." }
  end
end
