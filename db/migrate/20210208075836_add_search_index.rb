class AddSearchIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :title
    add_index :tasks, :content
    add_index :tasks, :status
    add_index :tasks, :deadline
    add_index :tasks, :priority
  end
end
