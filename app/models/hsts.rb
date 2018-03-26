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

  HSTS_URL_LIST = Settings.hsts_url_list

  # Whenever we create a new token, initialize it to a random value
  after_initialize do
    # Generate an array such as [ 1, 4, 8, 9 ], each number has 1/2 chance to appear
    self.token_ary ||= (0...HSTS_URL_LIST.length).select { SecureRandom.random_number(2) == 1 }
  end

end
