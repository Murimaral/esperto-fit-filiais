class BannedCustomer < ApplicationRecord
  belongs_to :user

  validates :cpf, :user, :reason, presence: true
  validates :cpf, uniqueness: true
  before_validation :set_banned_at_timestamp

  def save_and_send_to_api(enrollment)
    ActiveRecord::Base.transaction do
      save!
      enrollment.banned!
      #call api
      # raise ActiveRecord::Rollback # if api call fails
    end
  end

  private

  def set_banned_at_timestamp
    self.banned_at = Time.current
  end
end
