class Product < ApplicationRecord
  validates :name, :description, :min_price, presence: true
  validates :name, uniqueness: true
end
