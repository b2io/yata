class ListsController < ApplicationController
  respond_to :json

  # GET /lists.json
  def index
    respond_with @lists = List.find_all_by_user_id(current_user.id)
  end

  # GET /lists/1.json
  def show
    respond_with @list = List.find(params[:id])
  end

  # POST /lists.json
  def create
    respond_with @list = List.create(params[:list])
  end

  # PUT /lists/1.json
  def update
    respond_with @list = List.update(params[:id], params[:list])
  end

  # DELETE /lists/1.json
  def destroy
    respond_with List.destroy(params[:id])
  end

  def sort
    params[:list].each_with_index do |id, idx|
      List.update_all({ position: idx + 1 }, { id: id })
    end
    render nothing: true
  end

end
