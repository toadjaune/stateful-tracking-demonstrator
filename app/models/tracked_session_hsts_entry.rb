class TrackedSessionHstsEntry < ApplicationRecord
  belongs_to :tracked_session
  validates_presence_of :url_index
end
