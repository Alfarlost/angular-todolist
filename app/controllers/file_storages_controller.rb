class FileStoragesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    comment = Comment.find(params[:comment_id])
    @file = comment.file_storages.create(file_storage_params)
    render 'file_storages/create', status: 201
  end

private
  def file_storage_params
    params.permit(:file, :file_name)
  end
end
