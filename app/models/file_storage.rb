class FileStorage < ActiveRecord::Base
  mount_uploader :file, FileUploader
end
