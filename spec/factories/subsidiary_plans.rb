FactoryBot.define do
  factory :subsidiary_plan do
    subsidiary { create(:subsidiary) }
    plan { create(:plan) }
    status { :unavailable }
    final_price { rand(10..50).to_s }
  end
end
