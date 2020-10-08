require 'rails_helper'

RSpec.describe SubsidiaryPlan, type: :model do
  it 'final price must be grater than 0' do
    subsidiary = create(:subsidiary)
    plan = create(:plan)
    subsidiary_plan = build(:subsidiary_plan, subsidiary: subsidiary, plan: plan,
                                              final_price: '-10.00')

    subsidiary_plan.valid?

    expect(subsidiary_plan.errors[:final_price]).to include('deve ser maior que 0')
  end

  it 'cant duplicate plan in the same subsidiary' do
    subsidiary = create(:subsidiary)
    plan = create(:plan)
    create(:subsidiary_plan, subsidiary: subsidiary, plan: plan)
    subsidiary_plan = build(:subsidiary_plan, subsidiary: subsidiary, plan: plan)

    subsidiary_plan.valid?

    expect(subsidiary_plan.errors[:plan]).to include('já está em uso')
  end
end
