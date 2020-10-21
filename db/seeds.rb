include FactoryBot::Syntax::Methods

create(:user, email: 'admin@espertofit.com.br', password: '12345678', role: :admin, with_profile: false)

FactoryBot.create_list(:subsidiary, 3) do |subsidiary|
  subsidiary.images.attach(io: File.open(Rails.root.join('spec/fixtures/gym.jpg')), filename: 'gym.jpg')
  FactoryBot.create_list(:user, 3, with_profile: false, role: :employee, password: '123456') do |user|
    FactoryBot.create(:profile, user: user, subsidiary: subsidiary)
  end

  FactoryBot.create_list(:plan, 3) do |plan|
    FactoryBot.create(:subsidiary_plan, plan: plan, subsidiary: subsidiary, status: :available)
  end

  FactoryBot.create_list(:product, 3) do |product|
    FactoryBot.create(:subsidiary_product, product: product, subsidiary: subsidiary, status: :available)
  end

  FactoryBot.create(:schedule, subsidiary: subsidiary)
end

create_list(:banned_customer, 10)
