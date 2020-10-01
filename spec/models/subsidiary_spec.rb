require 'rails_helper'

RSpec.describe Subsidiary, type: :model do
  context 'validation' do
    it 'CNPJ must be unique' do
      Subsidiary.create!(name: 'Lorem', cnpj: '10.813.643/1863-76', address: 'R. Lorem, 123')
      new_subsidiary = Subsidiary.new(name: 'Lorem Ipsum', cnpj: '10.813.643/1863-76', address: 'R. Lorasem, 1as23')

      new_subsidiary.valid?

      expect(new_subsidiary.errors[:cnpj]).to include('já está em uso')
    end

    it 'name must be unique' do
      Subsidiary.create!(name: 'Lorem', cnpj: '10.813.643/1863-76', address: 'R. Lorem, 123')
      new_subsidiary = Subsidiary.new(name: 'Lorem', cnpj: '10.813.643/1863-76', address: 'R. Lorasem, 1as23')

      new_subsidiary.valid?

      expect(new_subsidiary.errors[:name]).to include('já está em uso')
    end
  end

  context 'token' do
    it 'generates a token on creation' do
      subsidiary = create(:subsidiary)

      expect(subsidiary.token).to be_present
      expect(subsidiary.token.size).to eq(6)
      expect(subsidiary.token).to match(/^[A-Z0-9]+$/)
    end

    it 'does not generate a token if validation fails' do
      subsidiary = Subsidiary.create(name: 'Lorem', cnpj: '10.400.643/1863-76', address: 'R. Lorem, 123')

      expect(subsidiary.token).not_to be_present
    end

    it 'must be unique' do
      subsidiary = create(:subsidiary)
      new_subsidiary = build(:subsidiary)
      allow(SecureRandom).to receive(:alphanumeric).and_return(subsidiary.token, 'ABC123')

      new_subsidiary.save

      expect(new_subsidiary).to be_persisted
      expect(new_subsidiary.token).not_to eq(subsidiary.token)
    end
  end
end
