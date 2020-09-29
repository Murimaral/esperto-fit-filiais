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

  it 'generates a token on creation' do
    subsidiary = create(:subsidiary)

    expect(subsidiary.token).to be_present
    expect(subsidiary.token.size).to eq(6)
    expect(subsidiary.token).to match(/^[A-Z0-9]+$/)
  end
end
