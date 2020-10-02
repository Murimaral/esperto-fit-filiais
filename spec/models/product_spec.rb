require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validation' do
    it 'product name must be unique' do
      create(:product, name: 'Lorem')
      new_product = build(:product, name: 'Lorem')

      new_product.valid?

      expect(new_product.errors[:name]).to include('já está em uso')
    end
  end
end
