FactoryBot.define do
  factory :subsidiary_plan do
    subsidiary { nil }
    plan { nil }
    status { 1 }
    final_price { '9.99' }
  end
end
