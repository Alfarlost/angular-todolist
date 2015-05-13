class Comment < ActiveRecord::Base
  has_many :file_storages, dependent: :destroy
end
