# == Schema Information
#
# Table name: tracked_sessions
#
#  id                    :integer          not null, primary key
#  session_id            :string
#  first_party_cookie_id :integer
#  local_storage_id       :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  etag_id               :integer
#

class TrackedSession < ApplicationRecord
  # This class is used to collect every tracking data related to a session

  validates_presence_of   :session_id

  belongs_to :first_party_cookie, required: false
  belongs_to :local_storage,      required: false
  belongs_to :etag,               required: false
  belongs_to :hpkp,               required: false

  has_many :tracked_session_hsts_entries

  def hsts
    Hsts.where(token_ary: hsts_token_ary).last
  end

  private

  def hsts_token_ary
    tracked_session_hsts_entries.order(:url_index).pluck(:url_index).uniq
  end
end
