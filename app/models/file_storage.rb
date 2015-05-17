class FileStorage < ActiveRecord::Base
  belongs_to :comment
  mount_uploader :file, FileUploader
end
