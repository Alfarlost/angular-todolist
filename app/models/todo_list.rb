class TodoList < ActiveRecord::Base
  has_many :tasks, -> { order("priority ASC") }, dependent: :destroy
end
