class RenameLocalStorageFieldTrackedSession < ActiveRecord::Migration[5.1]
  def change
    rename_column :tracked_sessions, :localstorage_id, :local_storage_id
  end
end
