class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :task_id

  has_many :file_storages
end
