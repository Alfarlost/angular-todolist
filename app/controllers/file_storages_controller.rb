class FileStoragesController < ApplicationController
  skip_before_action :verify_authenticity_token
  load_resource :comment
  load_and_authorize_resource :through => :comment

  def create
    if @file_storage.save
      render 'file_storages/create', status: 201
    else
      render nothing: true, status: 403
    end
  end

private
  def file_storage_params
    params.permit(:file, :file_name)
  end
end
