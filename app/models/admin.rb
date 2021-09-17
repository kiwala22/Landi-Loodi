class Admin < ApplicationRecord
  attr_writer :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:jwt_authenticatable,  jwt_revocation_strategy: JwtDenylist, authentication_keys: [:phone_number]


  def login
    @login || self.phone_number
  end
end
