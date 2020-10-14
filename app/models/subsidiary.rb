class Subsidiary < ApplicationRecord
  has_many :profiles, dependent: :destroy

  has_many :subsidiary_plans, dependent: :destroy
  has_many :plans, through: :subsidiary_plans
  has_many_attached :images
  validates :name, :address, :cnpj, presence: true
  validates :cnpj, :name, :token, uniqueness: true

  validate :cnpj_must_be_valid

  before_create :generate_token

  def cnpj_must_be_valid
    return if cnpj.blank? || CNPJ.valid?(cnpj)

    errors.add :cnpj, :invalid
  end

  private

  def generate_token
    self.token = loop do
      generated_token = SecureRandom.alphanumeric(6).upcase
      break generated_token unless Subsidiary.exists?(token: generated_token)
    end
  end
end
