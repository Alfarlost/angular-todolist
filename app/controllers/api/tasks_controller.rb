class Api::TasksController < ApplicationController
  before_filter :set_list

  def create
    task = @todo_list.tasks.create(task_params)
    respond_with task, location: api_todo_list_tasks_url
  end

  def update
    task = @todo_list.tasks.find(params[:id])
    task.update(task_params)
    respond_with nothing: true
  end
  
  def destroy
    @todo_list.tasks.destroy(params[:id])
    respond_with nothing: true
  end

  private
  def task_params
    params.require(:task).permit(:description, :priority, :completed, :deadline)
  end

  def set_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end 
end
