class Plan < ApplicationRecord
  validates :name, :default_price, :minimum_period, presence: true
  validates :name, uniqueness: true
  validates :default_price, :minimum_period, numericality: { greater_than: 0 }
end
