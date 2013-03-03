class AddLastSyncedToAuthentication < ActiveRecord::Migration
  def change
    add_column :authentications, :last_synced, :integer
  end
end
