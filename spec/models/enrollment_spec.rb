require 'rails_helper'

RSpec.describe Enrollment, type: :model do
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
