class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :email, unique: true
  end
end
