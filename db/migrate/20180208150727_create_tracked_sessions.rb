class CreateTrackedSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :tracked_sessions do |t|
      t.string :session_id
      t.belongs_to :first_party_cookie
      t.belongs_to :localstorage

      t.timestamps
    end
  end
end
