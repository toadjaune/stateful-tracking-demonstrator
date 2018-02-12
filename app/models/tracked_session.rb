class TrackedSession < ApplicationRecord
  # This class is used to collect every tracking data related to a session

  validates_presence_of   :session_id
  validates_uniqueness_of :session_id

  belongs_to :first_party_cookie, required: false
  belongs_to :localstorage,       required: false
  belongs_to :hsts,               required: false

  has_many :tracked_session_hsts_entries

  def hsts_token_set
    tracked_session_hsts_entries.ids.to_set
  end
end
