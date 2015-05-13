class Api::TodoListsController < ApplicationController
  def index
    respond_with TodoList.all.to_json(:include => :tasks)
  end

  def create
    todo_list = TodoList.create(todo_params)
    respond_with :api, todo_list
  end

  def update
    todo_list = TodoList.find(params[:id])
    todo_list.update(todo_params)
    respond_with nothing: true
  end

  def destroy
    respond_with TodoList.destroy(params[:id])
  end

  private

  def todo_params
    params.require(:todo_list).permit(:title)
  end 
end
