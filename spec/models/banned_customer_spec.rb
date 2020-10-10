require 'rails_helper'

RSpec.describe BannedCustomer, type: :model do
  context 'validations' do
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:banned_at) }
    it { should validate_presence_of(:reason) }
  end
end
