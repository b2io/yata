class ListsController < ApplicationController
  before_filter :authorize

  # GET /lists.json
  def index
    @lists = List.find_all_by_user_id(current_user.id)

    respond_to do |format|
      format.json { render json: @lists }
    end
  end

  # GET /lists/1.json
  def show
    @list = List.find(params[:id])

    respond_to do |format|
      format.json { render json: @list }
    end
  end

  # GET /lists/new.json
  def new
    @list = List.new
    @list.user_id = current_user.id

    respond_to do |format|
      format.json { render json: @list }
    end
  end

  # POST /lists.json
  def create
    @list = List.new(params[:list])
    @list.user_id = current_user.id

    respond_to do |format|
      if @list.save
        format.json { render json: @list, status: :created, location: @list }
      else
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1.json
  def update
    @list = List.find(params[:id])

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.json { head :no_content }
      else
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1.json
  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
