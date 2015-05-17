class Task < ActiveRecord::Base
  belongs_to :todo_list
  has_many :comments, dependent: :destroy
  acts_as_list column: :priority, scope: :todo_list, add_new_at: :top
end
