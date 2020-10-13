class BannedCustomer < ApplicationRecord
  belongs_to :user

  validates :cpf, :user, :reason, presence: true
  validates :cpf, uniqueness: true
  before_validation :set_banned_at_timestamp

  def send_data_to_customers_api
    response = Faraday.post("#{Rails.configuration.apis['customers']}/user/#{CPF.new(cpf).stripped}/ban")
    return false if response.status == 500

    true
  end

  private

  def set_banned_at_timestamp
    self.banned_at = Time.current
  end
end
