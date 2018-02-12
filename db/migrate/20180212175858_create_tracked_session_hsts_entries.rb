class CreateTrackedSessionHstsEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :tracked_session_hsts_entries do |t|
      t.belongs_to :tracked_session, foreign_key: true
      t.integer :url_index

      t.timestamps
    end
  end
end
