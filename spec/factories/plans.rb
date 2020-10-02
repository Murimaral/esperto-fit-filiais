FactoryBot.define do
  factory :plan do
    sequence(:name) {|n| "Plano#{n}"}
    default_price { '70.99' }
    minimum_period { '12' }
  end
end
