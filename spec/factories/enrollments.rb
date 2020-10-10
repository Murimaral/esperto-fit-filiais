FactoryBot.define do
  factory :enrollment do
    customer_name { 'Lorem Name' }
    customer_cpf { CPF.generate(true) }
    valid_thru { Date.current + 1.year }
    subsidiary_plan { create(:subsidiary_plan) }
    status { :active }
    email { 'loremail@teste.com.br' }
    price { 99.00 }
  end
end
