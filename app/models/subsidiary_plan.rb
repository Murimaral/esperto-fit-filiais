class SubsidiaryPlan < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :plan
  validates :final_price, presence: true

  enum status: { available: 0, unavailable: 1 }
end
