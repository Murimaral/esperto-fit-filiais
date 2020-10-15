class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_one :subsidiary, through: :profile
  has_many :banned_customers, dependent: :nullify

  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true

  enum role: { admin: 0, employee: 1 }
end
