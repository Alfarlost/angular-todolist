class FileStorageSerializer < ActiveModel::Serializer
  attributes :id, :file, :comment_id, :file_name
end
