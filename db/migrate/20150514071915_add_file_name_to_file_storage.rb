class AddFileNameToFileStorage < ActiveRecord::Migration
  def change
    add_column :file_storages, :file_name, :string
  end
end
