FactoryBot.define do
  factory :profile do
    full_name { 'MyString' }
    cpf { 'MyString' }
    address { 'MyText' }
    user { nil }
  end
end
