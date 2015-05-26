class Api::CommentsController < ApplicationController
  load_resource :todo_list
  load_resource :task, :through => :todo_list
  load_and_authorize_resource :through => :task 

  def create
    if @comment.save
      respond_with @comment, location: api_todo_list_task_comments_url
    else
      respond_with nothing: true, status: 403
    end
  end
 
  def destroy
    if @comment.destroy
      respond_with nothing: true
    else
      respond_with nothing: true, status: 403
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
