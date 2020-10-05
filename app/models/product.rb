class Product < ApplicationRecord
  validates :name, :description, :min_price, presence: true
  validates :name, uniqueness: true
  validates :min_price, numericality: { greater_than: 0 }
  has_one_attached :image
end
