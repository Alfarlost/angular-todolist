class TaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :priority, :deadline, :completed, :todo_list_id

  has_many :comments
end
