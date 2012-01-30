class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :text
      t.boolean :done
      t.integer :user_id

      t.timestamps
    end
  end
end
