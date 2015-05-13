class RemoveTodoListIndexFromTasks < ActiveRecord::Migration
  def change
    remove_index :tasks, name: :index_tasks_on_todo_list_id
  end
end
