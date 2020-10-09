require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    subject { create(:product) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_numericality_of(:min_price).is_greater_than(0) }
  end
end
