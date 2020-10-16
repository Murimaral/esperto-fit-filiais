require 'rails_helper'

RSpec.describe BannedCustomer, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  context 'validations' do
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:reason) }
  end

  context 'before validation' do
    it 'sets banned_at timestamp' do
      banned_customer = build(:banned_customer)

      travel_to Time.zone.local(2020, 11, 24, 12, 30, 44) do
        banned_customer.valid?
      end

      expect(banned_customer.banned_at).to eq(Time.zone.local(2020, 11, 24, 12, 30, 44))
    end
  end

  context 'sends data to customer api' do
    let(:banned_customer) { create(:banned_customer) }
    it 'and response has status 200' do
      faraday_response = double('faraday_response', status: 200)

      allow(Faraday).to receive(:post).with("#{Rails.configuration.apis['customers']}"\
                                           "/user/#{CPF.new(banned_customer.cpf).stripped}/ban")
                                      .and_return(faraday_response)

      expect(banned_customer.send_data_to_customers_api).to eq(true)
    end

    it 'and response has status 404' do
      faraday_response = double('faraday_response', status: 404)
      allow(Faraday).to receive(:post).with("#{Rails.configuration.apis['customers']}"\
                                           "/user/#{CPF.new(banned_customer.cpf).stripped}/ban")
                                      .and_return(faraday_response)

      expect(banned_customer.send_data_to_customers_api).to eq(true)
    end

    it 'and response has status 500' do
      faraday_response = double('faraday_response', status: 500)
      allow(Faraday).to receive(:post).with("#{Rails.configuration.apis['customers']}"\
                                           "/user/#{CPF.new(banned_customer.cpf).stripped}/ban")
                                      .and_return(faraday_response)

      expect(banned_customer.send_data_to_customers_api).to eq(false)
    end
  end
end
