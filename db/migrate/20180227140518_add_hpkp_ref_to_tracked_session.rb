class AddHpkpRefToTrackedSession < ActiveRecord::Migration[5.1]
  def change
    add_reference :tracked_sessions, :hpkp
  end
end
