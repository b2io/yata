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
        format.html { redirect_to profile_path, notice: "Profile was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit"}
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end
end
