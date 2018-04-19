class RemoveSubscriberBoxIdPermits < ActiveRecord::Migration[5.1]
  def change
    remove_column :permits, :subscriber_box_id
  end
end
