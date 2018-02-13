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

class FirstPartyCookie < ApplicationRecord
  belongs_to :user

  validates_presence_of :token
  validates_uniqueness_of :token

  # Whenever we create a new token, initialize it to a random string
  after_initialize do
    self.token ||= SecureRandom.hex
  end

end
