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

require 'rails_helper'

RSpec.describe Hsts, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
