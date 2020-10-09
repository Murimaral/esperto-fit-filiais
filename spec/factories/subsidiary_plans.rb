FactoryBot.define do
  factory :subsidiary_plan do
    subsidiary { create(:subsidiary) }
    plan { create(:plan) }
    status { :unavailable }
    final_price { '9.99' }
  end
end
