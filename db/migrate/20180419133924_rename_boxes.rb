class RenameBoxes < ActiveRecord::Migration[5.1]
  def change
    rename_table :boxes, :permits
  end
end
