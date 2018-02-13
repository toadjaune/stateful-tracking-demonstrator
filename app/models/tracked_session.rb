class TrackedSession < ApplicationRecord
  # This class is used to collect every tracking data related to a session

  validates_presence_of   :session_id

  belongs_to :first_party_cookie, required: false
  belongs_to :localstorage,       required: false

  has_many :tracked_session_hsts_entries

  def hsts
    Hsts.where(token_ary: hsts_token_ary).last
  end

  private

  def hsts_token_ary
    tracked_session_hsts_entries.order(:url_index).pluck(:url_index).uniq
  end
end
