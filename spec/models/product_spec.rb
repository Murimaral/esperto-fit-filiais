require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validation' do
    it 'name must be unique' do
      create(:product, name: 'Lorem')
      new_product = build(:product, name: 'Lorem')

      new_product.valid?

      expect(new_product.errors[:name]).to include('já está em uso')
    end

    it 'price must be a decimal greater than 0' do
      product = build(:product, min_price: -20)

      product.valid?

      expect(product.errors[:min_price]).to include('deve ser maior que 0')
    end

    it 'price must be a number' do
      product = build(:product, min_price: 'abc')

      product.valid?

      expect(product.errors[:min_price]).to include('não é um número')
    end
  end
end
