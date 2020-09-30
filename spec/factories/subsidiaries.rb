FactoryBot.define do
  factory :subsidiary do
    sequence(:name) { |i| "Lorem#{i}" }
    address { 'R. Lorem Ipsum, XXX, Lorem, Ipsum' }
    cnpj { CNPJ.generate(true) }
  end
end
