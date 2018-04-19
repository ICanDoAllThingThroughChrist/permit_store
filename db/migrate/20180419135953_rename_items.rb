class RenameItems < ActiveRecord::Migration[5.1]
  def change
    rename_table :items, :tasks
  end
end
