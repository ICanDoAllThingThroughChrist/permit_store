class RenameSubscriptionsToSites < ActiveRecord::Migration[5.1]
  def change
    rename_table :subscriptions, :sites
  end
end
