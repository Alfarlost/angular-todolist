class TodoListSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id

  has_many :tasks
end
