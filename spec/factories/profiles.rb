FactoryBot.define do
  factory :profile do
    full_name { Faker::Name.unique.name }
    cpf { CPF.generate(true) }
    address { Faker::Address.full_address }
    user { build(:user) }
    subsidiary { build(:subsidiary) }
  end
end
