class RenameColumnsToOrdersOfPermits < ActiveRecord::Migration[5.1]
  def change
    remove_column :order_of_permits, :box_id
    add_column :order_of_permits, :permit_id, :integer
  end
end
