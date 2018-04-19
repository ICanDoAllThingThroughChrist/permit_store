class RenameOrdersofboxessToOrdersOfPermits < ActiveRecord::Migration[5.1]
  def change
    rename_table :ordersofboxes, :order_of_permits
  end
end
