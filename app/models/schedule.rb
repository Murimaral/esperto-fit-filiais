class Schedule < ApplicationRecord
  belongs_to :subsidiary

  validates :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :holidays, presence: true
  validates :subsidiary, uniqueness: true
end
