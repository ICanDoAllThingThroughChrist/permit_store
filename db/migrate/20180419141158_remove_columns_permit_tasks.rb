class RemoveColumnsPermitTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :permit_tasks, :box_id
    add_column :permit_tasks, :permit_id, :integer
    remove_column :permit_tasks, :item_id
    add_column :permit_tasks, :task_id, :integer
    remove_column :permit_tasks, :integer
  end
end
