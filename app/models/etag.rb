# == Schema Information
#
# Table name: etags
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Etag < ApplicationRecord
  belongs_to :user

  validates_presence_of   :token
  validates_uniqueness_of :token

  # Whenever we create a new token, initialize it to a random string
  after_initialize do
    self.token ||= SecureRandom.hex
  end

end
