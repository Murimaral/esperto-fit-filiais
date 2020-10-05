feature 'Admin creates a plan' do
  scenario 'and must be logged in' do
    visit new_plan_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successufully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Gerenciar planos'
    click_on 'Novo plano'
    fill_in 'Nome', with: 'Premium'
    fill_in 'Preço padrão', with: '100.00'
    fill_in 'Permanência mínima', with: '6'
    click_on 'Criar plano'

    expect(page).to have_link('Voltar', href: plans_path)
    expect(page).to have_content('Premium')
    expect(page).to have_content('R$ 100,00')
    expect(page).to have_content('6 meses')
  end

  scenario 'and fields cant be blank' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Gerenciar planos'
    click_on 'Novo plano'
    fill_in 'Nome', with: ''
    fill_in 'Preço padrão', with: ''
    fill_in 'Permanência mínima', with: ''
    click_on 'Criar plano'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'and name must be unique' do
    user = create(:user)
    create(:plan, name: 'Premium')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Gerenciar planos'
    click_on 'Novo plano'
    fill_in 'Nome', with: 'Premium'
    fill_in 'Preço padrão', with: '100.00'
    fill_in 'Permanência mínima', with: '12'
    click_on 'Criar plano'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and default price and minimum period must be greater than 0' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Gerenciar planos'
    click_on 'Novo plano'
    fill_in 'Nome', with: 'Premium'
    fill_in 'Preço padrão', with: '-1.00'
    fill_in 'Permanência mínima', with: '-10'
    click_on 'Criar plano'

    expect(page).to have_content('Preço padrão deve ser maior que 0')
    expect(page).to have_content('Permanência mínima deve ser maior que 0')
  end
end
