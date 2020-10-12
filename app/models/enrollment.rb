class Enrollment < ApplicationRecord
  belongs_to :subsidiary_plan

  enum status: { active: 0, canceled: 10, banned: 20 }

  before_create :generate_token
  before_create :calculate_valid_thru
  before_create :format_customer_cpf

  validates :price, numericality: { greater_than: 0 }
  validates :customer_cpf, :price, :customer_name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :customer_cpf_must_be_valid

  def generate_token
    self.token = loop do
      generated_token = SecureRandom.alphanumeric(6).upcase
      break generated_token unless Enrollment.exists?(token: generated_token)
    end
  end

  def customer_cpf_must_be_valid
    return if customer_cpf.blank? || CPF.valid?(customer_cpf)

    errors.add :customer_cpf, :invalid
  end

  def format_customer_cpf
    self.customer_cpf = CPF.new(customer_cpf).formatted
  end

  def calculate_valid_thru
    self.valid_thru = Date.current + subsidiary_plan.plan.minimum_period.months
  end
end
