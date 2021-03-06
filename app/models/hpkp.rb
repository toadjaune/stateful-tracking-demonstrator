# == Schema Information
#
# Table name: hpkps
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Hpkp < ApplicationRecord
  belongs_to :user

  validates_presence_of   :token
  validates_uniqueness_of :token

  # Whenever we create a new token, initialize it to a random base64
  after_initialize do
    self.token ||= SecureRandom.base64(256)
  end

  def to_s
    token
  end
end
