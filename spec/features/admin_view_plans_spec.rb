feature 'admin view plans' do
  scenario 'successfully' do
    user = create(:user)
    create(:plan, name: 'Premium', default_price: '100.00',
                  minimum_period: '7')
    create(:plan, name: 'Básico', default_price: '59.99',
                  minimum_period: '5')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Gerenciar planos'

    expect(page).to have_css('td', text: 'Premium')
    expect(page).to have_css('td', text: 'R$ 100,00')
    expect(page).to have_css('td', text: '7 meses')
    expect(page).to have_css('td', text: 'Básico')
    expect(page).to have_css('td', text: 'R$ 59,99')
    expect(page).to have_css('td', text: '5 meses')
    expect(page).to_not have_content('Não há planos cadastrados')
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and there is no plan registered' do
    user = create(:user)

    login_as(user, scope: :user)
    visit plans_path

    expect(page).to have_css('h3', text: 'Não há planos cadastrados.')
  end

  scenario 'and must be logged in' do
    visit plans_path

    expect(current_path).to eq new_user_session_path
  end
end
