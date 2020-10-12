class BannedCustomer < ApplicationRecord
  belongs_to :user

  validates :cpf, :user, :reason, presence: true
  validates :cpf, uniqueness: true
  before_validation :set_banned_at_timestamp

  private

  def set_banned_at_timestamp
    self.banned_at = Time.current
  end
end
