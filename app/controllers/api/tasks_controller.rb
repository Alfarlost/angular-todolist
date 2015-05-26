class Api::TasksController < ApplicationController
  load_resource :todo_list
  load_and_authorize_resource :through => :todo_list

  def create
    if @task.save
      respond_with @task, location: api_todo_list_tasks_url
    else
      respond_with nothing: true, status: 403
    end
  end

  def update
    if @task.update(task_params)
      respond_with nothing: true
    else
      respond_with nothing: true, status: 403
    end
  end
  
  def destroy
    if @task.destroy
      respond_with nothing: true
    else
      respond_with nothing: true, status: 403
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :priority, :completed, :deadline)
  end
end
