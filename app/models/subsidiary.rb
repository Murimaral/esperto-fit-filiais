class Subsidiary < ApplicationRecord
  has_one :schedule, dependent: :destroy

  validates :name, :address, :cnpj, presence: true
  validates :cnpj, :name, uniqueness: true

  validate :cnpj_must_be_valid

  before_create :generate_token

  def cnpj_must_be_valid
    return if cnpj.blank? || CNPJ.valid?(cnpj)

    errors.add(:cnpj, 'não é válido')
  end

  private

  def generate_token
    self.token = SecureRandom.alphanumeric(6).upcase
  end
end
