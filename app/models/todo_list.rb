class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, -> { order("priority DESC") }

end
