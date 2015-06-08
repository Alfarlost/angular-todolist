class DeleteUsersForeignKey < ActiveRecord::Migration
  def change
    remove_foreign_key :todo_lists, :users
  end
end
