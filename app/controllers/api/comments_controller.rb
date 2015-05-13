class Api::CommentsController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    comment = task.comments.create(comment_params)
    respond_with comment, location: api_todo_list_task_comments_url
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
