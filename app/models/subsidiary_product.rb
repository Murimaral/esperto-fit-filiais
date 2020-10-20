class SubsidiaryProduct < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :product
  validates :final_price, presence: true, numericality: { greater_than: 0 }
  validates :product, uniqueness: { scope: :subsidiary_id }

  enum status: { available: 0, unavailable: 10 }
end
