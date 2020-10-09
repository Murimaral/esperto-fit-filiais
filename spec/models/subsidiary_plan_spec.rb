require 'rails_helper'

RSpec.describe SubsidiaryPlan, type: :model do
  describe 'validations' do
    subject { create(:subsidiary_plan) }
    it { should validate_uniqueness_of(:plan).scoped_to(:subsidiary_id) }
    it { should validate_numericality_of(:final_price).is_greater_than(0) }
  end
end
