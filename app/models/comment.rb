class Comment < ActiveRecord::Base
  belongs_to :task
  has_many :file_storages, dependent: :destroy
end
