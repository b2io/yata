class AuthorizationsController < ApplicationController
  before_filter :authorize

  def destroy
    @authorization = Authorization.find(params[:id])
    @authorization.destroy

    respond_to do |format|
      format.html { redirect_to profile_path + "#/accounts" }
      format.json { head :no_content }
    end
  end

end
