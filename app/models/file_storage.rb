class FileStorage < ActiveRecord::Base
  belongs_to :comment
  mount_uploader :file, FileUploader

  validates_size_of :file, maximum: 24.megabytes
end
