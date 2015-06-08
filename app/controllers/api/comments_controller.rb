class Api::CommentsController < ApplicationController
  load_and_authorize_resource :except => :create 

  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build(comment_params)
    authorize! :create, @comment
    if @comment.save
      render json: @comment, serializer: CommentSerializer, status: 201
    else
      render nothing: true, status: 403
    end
  end
 
  def destroy
    if @comment.destroy
      render nothing: true, status: 204
    else
      render nothing: true, status: 403
    end
  end

  private

  def comment_params
    params.permit(:body)
  end
end
