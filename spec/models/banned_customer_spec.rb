require 'rails_helper'

RSpec.describe BannedCustomer, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  context 'validations' do
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:reason) }
  end

  context 'methods' do
    it 'sets banned_at timestamp before validation' do
      banned_customer = build(:banned_customer)

      travel_to Time.zone.local(2020, 11, 24, 12, 30, 44) do
        banned_customer.valid?
      end

      expect(banned_customer.banned_at).to eq(Time.zone.local(2020, 11, 24, 12, 30, 44))
    end
  end
end
