# == Schema Information
#
# Table name: tracked_session_hsts_entries
#
#  id                 :integer          not null, primary key
#  tracked_session_id :integer
#  url_index          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class TrackedSessionHstsEntry < ApplicationRecord
  belongs_to :tracked_session
  validates_presence_of :url_index
end
