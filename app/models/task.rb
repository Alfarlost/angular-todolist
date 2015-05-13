class Task < ActiveRecord::Base
  belongs_to :todo_list
  acts_as_list column: :priority, scope: :todo_list, add_new_at: :top
end
