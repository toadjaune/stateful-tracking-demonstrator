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

require 'rails_helper'

RSpec.describe TrackedSessionHstsEntry, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
