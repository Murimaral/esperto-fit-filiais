FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "teste#{n}@espertofit.com.br" }
    password { '123456' }
  end
end
