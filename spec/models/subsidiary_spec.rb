require 'rails_helper'

RSpec.describe Subsidiary, type: :model do
  it 'generates a token on creation' do
    subsidiary = create(:subsidiary)

    expect(subsidiary.token).to be_present
    expect(subsidiary.token.size).to eq(6)
    expect(subsidiary.token).to match(/^[A-Z0-9]+$/)
  end
end
