class RemoveForeighnKeyFromTasks < ActiveRecord::Migration
  def change
    remove_foreign_key :tasks, :todo_lists
  end
end
