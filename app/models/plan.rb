class Plan < ApplicationRecord
    validates :name, :default_price, :minimum_period , presence: true
end
