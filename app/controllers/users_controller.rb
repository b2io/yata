class UsersController < ApplicationController
  before_filter :authorize

  def profile
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html {
          flash[:success] = "Your profile has been updated."
          render :profile
        }
        format.json { head :no_content }
      else
        format.html {
          flash[:error] = "There were errors updating your profile."
          render :profile
        }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end
end
