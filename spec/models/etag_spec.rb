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

require 'rails_helper'

RSpec.describe Etag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
