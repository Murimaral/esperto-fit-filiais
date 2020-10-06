class Enrollment < ApplicationRecord
  before_create :generate_token
  def generate_token
    self.token = loop do
      generated_token = SecureRandom.alphanumeric(6).upcase
      break generated_token unless Enrollment.exists?(token: generated_token)
    end
  end
end
