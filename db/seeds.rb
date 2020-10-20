
include FactoryBot::Syntax::Methods
create(:user, email: 'admin@espertofit.com.br', password: '12345678', role: :admin)



FactoryBot.create_list(:subsidiary, 3) do |subsidiary|
 
    FactoryBot.create_list(:user, 3,role: :employee) do |user|
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




