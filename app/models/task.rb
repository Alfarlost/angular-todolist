class Task < ActiveRecord::Base
  belongs_to :todo_list
  acts_as_list scope: :todo_list, column: :priority, add_new_at: :top
end
