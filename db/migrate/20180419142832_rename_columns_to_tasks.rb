class RenameColumnsToTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :box_item_id
    add_column :tasks, :permit_task_id, :integer
  end
end
