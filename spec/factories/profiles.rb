FactoryBot.define do
  factory :profile do
    full_name { 'MyString' }
    cpf { CPF.generate(true) }
    address { 'MyText' }
    user { build(:user) }
    subsidiary { build(:subsidiary) }
  end
end
