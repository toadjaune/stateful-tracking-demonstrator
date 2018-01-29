class User < ApplicationRecord

  has_many :first_party_cookies, class_name: 'FirstPartyCookie' # Rails stupid pluralization rules
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable, :trackable, 
  devise :database_authenticatable, :registerable, :validatable

  def to_s
    email
  end
end
