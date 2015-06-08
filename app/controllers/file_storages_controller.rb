class FileStoragesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @comment = Comment.find(params[:comment_id])
    @file_storage = @comment.file_storages.build(file_storage_params)
    authorize! :create, @file_storage
    if @file_storage.save
      render json: @file_storage, serializer: FileStorageSerializer, status: 201
    else
      render nothing: true, status: 403
    end
  end

private
  def file_storage_params
    params.permit(:file, :file_name)
  end
end
