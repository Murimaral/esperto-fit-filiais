FactoryBot.define do
  factory :banned_customer do
    reason { 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Non, consequuntur?' }
    banned_at { Time.current }
    user { create(:user) }
    cpf { CPF.generate(true) }
  end
end
