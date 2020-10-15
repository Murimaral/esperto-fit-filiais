require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'validations' do
    subject { create(:schedule) }
    it { should validate_uniqueness_of(:subsidiary) }
    it { should validate_presence_of(:monday) }
    it { should validate_presence_of(:tuesday) }
    it { should validate_presence_of(:wednesday) }
    it { should validate_presence_of(:thursday) }
    it { should validate_presence_of(:friday) }
    it { should validate_presence_of(:saturday) }
    it { should validate_presence_of(:sunday) }
    it { should validate_presence_of(:holidays) }
  end
end
