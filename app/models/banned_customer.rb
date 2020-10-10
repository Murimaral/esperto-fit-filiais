class BannedCustomer < ApplicationRecord
  belongs_to :user

  validates :cpf, :user, :banned_at, :reason, presence: true
  validates :cpf, uniqueness: true
end
