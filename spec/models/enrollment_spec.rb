require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  context 'methods' do
    it 'calculates the valid_thru according to plan' do
      plan = create(:plan, minimum_period: 5)
      subsidiary_plan = create(:subsidiary_plan, plan: plan)
      enrollment = create(:enrollment, subsidiary_plan: subsidiary_plan)

      expect(enrollment.valid_thru).to eq(Date.current + plan.minimum_period.months)
    end

    it 'generates a token on creation' do
      enrollment = create(:enrollment)

      expect(enrollment.token.size).to eq(6)
      expect(enrollment.token).to match(/^[A-Z0-9]+$/)
    end

    it 'token must be unique' do
      enrollment = create(:enrollment)
      new_enrollment = build(:enrollment)
      allow(SecureRandom).to receive(:alphanumeric).and_return(enrollment.token, 'ABC123')

      new_enrollment.save

      expect(new_enrollment).to be_persisted
      expect(new_enrollment.token).not_to eq(enrollment.token)
    end
  end

  context 'validations' do
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should allow_value('email@address.foo').for(:email) }
    it { should_not allow_value('foo').for(:email) }
    it { should allow_value('924.737.808-70').for(:customer_cpf) }
    it { should allow_value('92473780870').for(:customer_cpf) }
    it { should_not allow_value('123.123.000-00').for(:customer_cpf) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:customer_name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:customer_cpf) }

    it 'customer cpf is always formatted' do
      enrollment = create(:enrollment, customer_cpf: '92473780870')

      expect(enrollment.customer_cpf).to eq('924.737.808-70')
    end
  end
end
