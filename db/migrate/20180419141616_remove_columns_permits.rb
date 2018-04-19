class RemoveColumnsPermits < ActiveRecord::Migration[5.1]
  def change
    remove_column :permits, :subscription_level
    add_column :permits, :permit_types, :string
  end
end
