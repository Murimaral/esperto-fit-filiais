class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true
  validate  :email_must_be_espertofit

  enum role: { admin: 0, employee: 1 }

  def email_must_be_espertofit
    return if email.present? && email.slice(/@.*/).to_s == '@espertofit.com.br'

    errors.add(:email, 'deve ter o domínio @espertofit.com.br')
  end
end
