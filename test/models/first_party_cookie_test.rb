# == Schema Information
#
# Table name: first_party_cookies
#
#  id         :integer          not null, primary key
#  token      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FirstPartyCookieTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
