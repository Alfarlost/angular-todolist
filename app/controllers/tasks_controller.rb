class TasksController < ApplicationController
  def index
    respond_with TodoList.all
  end

  def create
    respond_with Todolist.create(todo_params)
  end

  private

  def todo_params
    params.require(:todo_list).permit(:title) 
end
