# == Schema Information
#
# Table name: hsts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  token_ary  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Hsts < ApplicationRecord
  belongs_to :user

  serialize               :token_ary
  validates_presence_of   :token_ary
  validates_uniqueness_of :token_ary

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

  # Whenever we create a new token, initialize it to a random value
  after_initialize do
    # Generate an array such as [ 1, 4, 8, 9 ], each number has 1/2 chance to appear
    self.token_ary ||= (0...HSTS_URL_LIST.length).select { SecureRandom.random_number(2) == 1 }
  end

end
