class Api::TodoListsController < ApplicationController
  load_and_authorize_resource

  def index
    respond_with @todo_lists.to_json(:include => { :tasks => { 
                                                      :include => { :comments => { 
                                                        :include => { :file_storages => {
                                                          :except => [:created_at, :updated_at] } }, 
                                                        :except => [:created_at, :updated_at] } },
                                                      :except => [:created_at, :updated_at] } }, 
                                                    :except => [:created_at, :updated_at])
  end

  def create
    if @todo_list.save
      respond_with :api, @todo_list
    else
      respond_with nothing: true, status: 403
    end
  end

  def update
    if @todo_list.update(todo_list_params)
      respond_with nothing: true
    else
      respond_with nothing: true, status: 403
    end
  end

  def destroy
    if @todo_list.destroy
      respond_with nothing: true
    else
      respond_with nothing: true, status: 403
    end
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:title)
  end 
end
