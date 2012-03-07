class ChecklistItemsController < ApplicationController
  respond_to :json

  def index
    respond_with @checklist_item = ChecklistItem.all()
  end

  def show
    respond_with @checklist_item = ChecklistItem.find(params[:id])
  end

  def create
    respond_with @checklist_item = ChecklistItem.create(params[:checklist_item])
  end

  def update
    respond_with @checklist_item = ChecklistItem.update(params[:id], params[:checklist_item])
  end

  def destroy
    respond_with ChecklistItem.destroy(params[:id])
  end

end
