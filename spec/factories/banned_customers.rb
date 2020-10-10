FactoryBot.define do
  factory :banned_customer do
    reason { 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Non, consequuntur?' }
    banned_at { '2020-10-09 19:37:43' }
    user { create(:user) }
    cpf { CPF.generate(true) }
  end
end
