FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "teste#{n}@espertofit.com.br" }
    password { '123456' }
    role { 'admin' }

    transient do
      with_profile { true }
    end

    after(:create) do |user, evaluator|
      create(:profile, user: user) if evaluator.with_profile
    end
  end
end
