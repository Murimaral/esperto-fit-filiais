class Enrollment < ApplicationRecord
  belongs_to :subsidiary_plan

  enum status: { active: 0, canceled: 10, banned: 20 }

  before_create :generate_token
  before_create :calculate_valid_thru

  def generate_token
    self.token = loop do
      generated_token = SecureRandom.alphanumeric(6).upcase
      break generated_token unless Enrollment.exists?(token: generated_token)
    end
  end

  def calculate_valid_thru
    self.valid_thru = Date.current + subsidiary_plan.plan.minimum_period.months
  end
end
