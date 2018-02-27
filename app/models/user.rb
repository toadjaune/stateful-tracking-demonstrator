# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string
#  last_sign_in_ip    :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ApplicationRecord

  has_many :first_party_cookies, class_name: 'FirstPartyCookie' # Rails stupid pluralization rules
  has_many :local_storages
  has_many :hstss
  has_many :etags
  has_many :hpkps

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable, :trackable, 
  devise :database_authenticatable, :registerable, :validatable

  def to_s
    email
  end
end
