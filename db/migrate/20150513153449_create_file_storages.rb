class CreateFileStorages < ActiveRecord::Migration
  def change
    create_table :file_storages do |t|
      t.string :file

      t.timestamps null: false
    end
  end
end
