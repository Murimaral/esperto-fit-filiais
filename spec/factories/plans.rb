FactoryBot.define do
  factory :plan do
    name { 'MyString' }
    default_price { '70.99' }
    minimum_period { '12' }
  end
end
