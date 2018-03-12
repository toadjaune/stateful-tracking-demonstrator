class AddRedirectionToTrackedSession < ActiveRecord::Migration[5.1]
  def change
    add_reference :tracked_sessions, :redirection
  end
end
