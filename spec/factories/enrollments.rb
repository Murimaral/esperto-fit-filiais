FactoryBot.define do
  factory :enrollment do
    customer_name { 'MyString' }
    customer_cpf { CPF.generate(true) }
    valid_thru { Date.current + 1.year }
  end
end
