# == Schema Information
#
# Table name: tracked_sessions
#
#  id                    :integer          not null, primary key
#  session_id            :string
#  first_party_cookie_id :integer
#  localstorage_id       :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  etag_id               :integer
#

require 'rails_helper'

RSpec.describe TrackedSession, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
