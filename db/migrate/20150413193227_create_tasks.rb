class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.integer :priority
      t.date :deadline
      t.boolean :completed, default: false
      t.references :todo_list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
