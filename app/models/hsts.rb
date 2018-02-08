class Hsts < ApplicationRecord
  belongs_to :user

  validates_presence_of :token
  validates_uniqueness_of :token

  # This is currently hardcoded, TODO : migrate it to a configuration option
  HSTS_URL_LIST = [
    "hsts001.tracker.toadjaune.eu",
    "hsts002.tracker.toadjaune.eu",
    "hsts003.tracker.toadjaune.eu",
    "hsts004.tracker.toadjaune.eu",
    "hsts005.tracker.toadjaune.eu",
    "hsts006.tracker.toadjaune.eu",
    "hsts007.tracker.toadjaune.eu",
    "hsts008.tracker.toadjaune.eu",
    "hsts009.tracker.toadjaune.eu",
    "hsts010.tracker.toadjaune.eu"
  ]

  # Whenever we create a new token, initialize it to a random string
  after_initialize do
    # Generate a string in the form "1101011100010", of same length as HSTS_URL_LIST
    self.token ||= (0...HSTS_URL_LIST.length).map { SecureRandom.random_number(2) }.join
  end

  def to_s
    token
  end
end
