FactoryBot.define do
  factory :subsidiary_product do
    subsidiary { create(:subsidiary) }
    product { create(:product) }
    status { :unavailable }
    final_price { '99.99' }
  end
end
