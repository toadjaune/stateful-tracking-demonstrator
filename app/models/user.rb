class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable, :trackable, 
  devise :database_authenticatable, :registerable, :validatable

  def to_s
    email
  end
end
