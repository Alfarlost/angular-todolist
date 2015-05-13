class Task < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  acts_as_list column: :priority, scope: :todo_list, add_new_at: :top
end
