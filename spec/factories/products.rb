FactoryBot.define do
  factory :product do
    sequence(:name) { |i| "Lorem#{i}" }
    description { 'Lorem Ipsum' }
    min_price { 9.99 }
  end
end
