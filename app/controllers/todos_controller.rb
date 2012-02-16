class TodosController < ApplicationController
  before_filter :authorize

  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.find_all_by_user_id_and_list_id(current_user.id, params[:list])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.json { render json: @todo }
    end
  end

  # GET /todos/new.json
  def new
    @todo = Todo.new
    @todo.user_id = current_user.id

    respond_to do |format|
      format.json { render json: @todo }
    end
  end

  # POST /todos.json
  def create
    @todo = Todo.new(params[:list])
    @todo.user_id = current_user.id

    respond_to do |format|
      if @list.save
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1.json
  def update
    @todo = Todo.find(params[:id])

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.json { head :no_content }
      else
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
