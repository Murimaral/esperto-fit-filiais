require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
    subject { create(:profile) }
    it { should allow_value('924.737.808-70').for(:cpf) }
    it { should allow_value('92473780870').for(:cpf) }
    it { should_not allow_value('123.123.000-00').for(:cpf) }
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:subsidiary) }
  end
end
