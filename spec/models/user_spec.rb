require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should allow_value('email@espertofit.com.br').for(:email) }
    it { should_not allow_value('email@address.foo').for(:email) }
    it { should_not allow_value('foo').for(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should_not allow_value('123').for(:password) }
    it { should validate_presence_of(:role) }
  end
end
