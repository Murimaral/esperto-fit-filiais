class Profile < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :user, optional: true
  accepts_nested_attributes_for :user
end
