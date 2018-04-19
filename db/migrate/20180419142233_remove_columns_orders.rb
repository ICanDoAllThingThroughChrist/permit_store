class RemoveColumnsOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :subscription_id
    add_column :orders, :site_id, :integer
  end
end
