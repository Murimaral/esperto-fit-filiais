class Profile < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :user, optional: true
  accepts_nested_attributes_for :user

  validates :full_name, :cpf, :address, :subsidiary, :user, presence: true
  validate :cpf_must_be_valid

  def cpf_must_be_valid
    return if cpf.blank? || CPF.valid?(cpf)

    errors.add :cpf, :invalid
  end
end
