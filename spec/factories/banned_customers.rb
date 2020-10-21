FactoryBot.define do
  factory :banned_customer do
    reason { 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Non, consequuntur?' }
    user { create(:user, with_profile: false) }
    cpf { CPF.generate(true) }
  end
end
