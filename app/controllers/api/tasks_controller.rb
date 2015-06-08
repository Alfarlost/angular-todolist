class Api::TasksController < ApplicationController
  load_and_authorize_resource :except => :create 

  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @task = @todo_list.tasks.build(task_params)
    authorize! :create, @task
    if @task.save
      render json: @task, serializer: TaskSerializer, status: 201
    else
      render nothing: true, status: 403
    end
  end

  def update
    if @task.update(task_params)
      render nothing: true, status: 204
    else
      render nothing: true, status: 403
    end
  end
  
  def destroy
    if @task.destroy
      render nothing: true, status: 204
    else
      render nothing: true, status: 403
    end
  end

  private

  def task_params
    params.permit(:description, :priority, :completed, :deadline)
  end
end
