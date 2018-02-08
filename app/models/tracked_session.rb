class TrackedSession < ApplicationRecord
  # This class is used to collect every tracking data related to a session

  validates_presence_of   :session_id
  validates_uniqueness_of :session_id
  validates_presence_of   :hsts_token # This token is progressively built with each https request

  belongs_to :first_party_cookie, required: false
  belongs_to :localstorage,       required: false
  belongs_to :hsts,               required: false

  after_initialize do
    # Generate a string in the form "0000000000000", of same length as HSTS_URL_LIST
    self.hsts_token ||= '0' * Hsts::HSTS_URL_LIST.length
  end
end
