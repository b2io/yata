class AuthorizationsController < ApplicationController

  def destroy
    @authorization = Authorization.find(params[:id])
    @authorization.destroy

    respond_to do |format|
      format.html { redirect_to profile_path + "#/accounts", flash: { success: "Successfully unlinked that login from your YATA account." } }
      format.json { head :no_content }
    end
  end

  protected

  def authorize
    # Run basic authorization.
    super

    # If the authorization doesn't belong to the user, forbid the action.
    unless Authorization.find(params[:id]).user_id == current_user.id && current_user.authorizations.length > 1
      redirect_to "/", flash: { error: "Unauthorized access." }
      false
    end
  end

end
