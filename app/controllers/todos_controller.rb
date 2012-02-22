class TodosController < ApplicationController
  respond_to :json

  def index
    respond_with @todos = Todo.find_all_by_user_id(current_user.id)
  end

  def show
    respond_with @todo = Todo.find(params[:id])
  end

  def create
    respond_with @todo = Todo.create(params[:todo])
  end

  def update
    respond_with @todo = Todo.update(params[:id], params[:todo])
  end

  def destroy
    respond_with Todo.destroy(params[:id])
  end

  def sort
    params[:todo].each_with_index do |id, idx|
      Todo.update_all({ position: idx + 1 }, { id: id })
    end
    render nothing: true
  end
end
