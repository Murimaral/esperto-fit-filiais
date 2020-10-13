class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true

  enum role: { admin: 0, employee: 1 }
end
