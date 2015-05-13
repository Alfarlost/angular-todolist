class AddCommentIdToFileStorageTable < ActiveRecord::Migration
  def change
    add_column :file_storages, :comment_id,  :integer
  end
end
