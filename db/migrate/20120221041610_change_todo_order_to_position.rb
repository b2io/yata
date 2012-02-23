class ChangeTodoOrderToPosition < ActiveRecord::Migration
  def change
    rename_column :todos, :order, :position
  end
end
