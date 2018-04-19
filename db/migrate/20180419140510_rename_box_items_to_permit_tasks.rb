class RenameBoxItemsToPermitTasks < ActiveRecord::Migration[5.1]
  def change
    rename_table :box_items, :permit_tasks
  end
end
