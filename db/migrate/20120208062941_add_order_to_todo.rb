class AddOrderToTodo < ActiveRecord::Migration
  def change
    add_column :todos, :order, :integer

  end
end
