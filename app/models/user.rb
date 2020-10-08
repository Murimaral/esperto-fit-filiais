class User < ApplicationRecord
  has_one :profile
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum role: {admin: 0, employee: 1}
end
