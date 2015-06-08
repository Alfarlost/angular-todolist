class Api::TodoListsController < ApplicationController
  load_and_authorize_resource

  def index
    render json: @todo_lists, each_serializer: TodoListSerializer
  end

  def create
    if @todo_list.save
      render json: @todo_list, serializer: TodoListSerializer, status: 201
    else
      render nothing: true, status: 403
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      render nothing: true, status: 204
    else
      render nothing: true, status: 403
    end
  end

  def destroy
    if @todo_list.destroy
      render nothing: true, status: 204
    else
      render nothing: true, status: 403
    end
  end

  private

  def todo_list_params
    params.permit(:title)
  end 
end
