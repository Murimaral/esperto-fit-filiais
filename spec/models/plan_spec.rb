require 'rails_helper'

RSpec.describe Plan, type: :model do
  context 'validation' do
    it 'name must be unique' do
      create(:plan, name: 'Premium')
      another_plan = build(:plan, name: 'Premium')

      another_plan.valid?

      expect(another_plan.errors[:name]).to include('já está em uso')
    end
    
    it 'default price must be greater than 0' do
       plan = build(:plan, default_price: -19)

       plan.valid?

       expect(plan.errors[:default_price]).to include('deve ser maior que 0')
    end

    it 'minimum period must be greater than 0' do
      plan = build(:plan, minimum_period: '-10')

      plan.valid?

      expect(plan.errors[:minimum_period]).to include('deve ser maior que 0')
    end
  end
end
