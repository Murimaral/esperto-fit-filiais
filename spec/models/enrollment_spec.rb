require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  context 'validation' do
    it 'customer CPF must be unique' do
      create(:enrollment, customer_cpf: '901.516.426-64')
      new_enrollment = build(:enrollment, customer_cpf: '901.516.426-64')

      new_enrollment.valid?

      expect(new_enrollment.errors[:customer_cpf]).to include('já está em uso')
    end

    it 'valid thru must be greater than current date' do
      enrollment = build(:enrollment, valid_thru: Date.yesterday)

      enrollment.valid?

      expect(enrollment.errors[:valid_thru]).to include('deve ser maior ou igual a')
    end
  end

  context 'token' do
    it 'generates a token on creation' do
      enrollment = create(:enrollment)

      expect(enrollment.token.size).to eq(6)
      expect(enrollment.token).to match(/^[A-Z0-9]+$/)
    end

    it 'must be unique' do
      enrollment = create(:enrollment)
      new_enrollment = build(:enrollment)
      allow(SecureRandom).to receive(:alphanumeric).and_return(enrollment.token, 'ABC123')

      new_enrollment.save

      expect(new_enrollment).to be_persisted
      expect(new_enrollment.token).not_to eq(enrollment.token)
    end
  end
end
