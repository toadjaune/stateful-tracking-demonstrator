class LocalStorage < ApplicationRecord
  belongs_to :user

  validates_presence_of :token
  validates_uniqueness_of :token

  # Whenever we create a new token, initialize it to a random string
  after_initialize do
    self.token ||= SecureRandom.hex
  end

  def to_s
    token
  end
end
