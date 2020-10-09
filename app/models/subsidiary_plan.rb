class SubsidiaryPlan < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :plan
  validates :final_price, presence: true, numericality: { greater_than: 0 }
  validates :plan, uniqueness: { scope: :subsidiary_id }

  enum status: { available: 0, unavailable: 10 }
end
