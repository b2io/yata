class UsersController < ApplicationController
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
          redirect_to :profile, flash: { success: "Your profile has been updated." }
        }
        format.json { head :no_content }
      else
        format.html {
          flash[:error] = "There were errors updating your profile."
          render :profile
        }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    session.delete(:user_id)
    redirect_to "/", flash: { success: "Your account has been deleted." }
  end

end
