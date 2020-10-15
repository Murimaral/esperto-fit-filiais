require 'rails_helper'

feature 'User views banned customers' do
  include ActiveSupport::Testing::TimeHelpers

  scenario 'successfully' do
    user = create(:user, role: :employee)
    subsidiary = create(:subsidiary)
    create(:profile, user: user, subsidiary: subsidiary)
    create(:banned_customer, cpf: '435.955.239-46', user: user)
    create(:banned_customer, cpf: '787.057.058-35', user: user)
    create(:banned_customer, cpf: '798.989.022-48', user: user)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar banimentos'

    expect(page).to have_content('435.955.239-46')
    expect(page).to have_content('787.057.058-35')
    expect(page).to have_content('798.989.022-48')
    expect(page).to have_content(user.email, count: 3)
  end

  scenario 'and view banned customer details' do
    user = create(:user, role: :employee)
    travel_to Time.zone.local(2020, 11, 24, 12, 30, 44) do
      create(:banned_customer, cpf: '435.955.239-46', user: user, reason: 'Mal educado')
    end

    login_as user
    visit subsidiary_banned_customers_path(user.subsidiary)
    click_on '435.955.239-46'

    expect(page).to have_content('435.955.239-46')
    expect(page).to have_content(user.email)
    expect(page).to have_content('Mal educado')
    expect(page).to have_content('24/11/2020 às 12:30')
    expect(page).to have_link('Voltar', href: subsidiary_banned_customers_path(user.subsidiary))
  end

  scenario 'and are no banned customers' do
    user = create(:user, role: :employee)
    subsidiary = create(:subsidiary)

    login_as user
    visit subsidiary_banned_customers_path(subsidiary)

    expect(page).to have_content('Não há clientes banidos.')
  end

  scenario 'must be logged in' do
    subsidiary = create(:subsidiary)
    visit subsidiary_banned_customers_path(subsidiary)

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'must be logged in to view details' do
    subsidiary = create(:subsidiary)
    banned_customer = create(:banned_customer)

    visit subsidiary_banned_customer_path(subsidiary, banned_customer)

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and view only banned customer users subsidiary' do
    subsidiary = create(:subsidiary, name: 'Carioca')
    user = create(:user, role: :employee)
    create(:profile, user: user, subsidiary: subsidiary)
    create(:banned_customer, cpf: '435.955.239-46', user: user)
    create(:banned_customer, cpf: '787.057.058-35', user: user)
    create(:banned_customer, cpf: '798.989.022-48')

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar banimentos'

    expect(page).to have_content('435.955.239-46')
    expect(page).to have_content('787.057.058-35')
    expect(page).to_not have_content('798.989.022-48')
  end
end
