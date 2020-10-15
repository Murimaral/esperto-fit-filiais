feature 'Admin edit plan' do
  scenario 'and must be logged in' do
    plan = create(:plan)

    visit edit_plan_path(plan)

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    user = create(:user)
    create(:plan, name: 'Básico', default_price: '79.00',
                  minimum_period: 6)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Gerenciar planos'
    click_on 'Básico'
    click_on 'Editar plano'
    fill_in 'Nome', with: 'Super básico'
    fill_in 'Preço padrão', with: '50.00'
    fill_in 'Permanência mínima', with: '4'
    click_on 'Enviar'

    expect(page).to have_content('Super básico')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('4 meses')
  end

  scenario 'and fields cant be blank' do
    user = create(:user)
    plan = create(:plan, name: 'Básico', default_price: '79.00',
                         minimum_period: 6)

    login_as(user, scope: :user)
    visit plan_path(plan)
    click_on 'Editar plano'
    fill_in 'Nome', with: ''
    fill_in 'Preço padrão', with: ''
    fill_in 'Permanência mínima', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'and minimum period must be grater than 0' do
    user = create(:user)
    plan = create(:plan, name: 'Básico', default_price: '79.00',
                         minimum_period: 6)

    login_as(user, scope: :user)
    visit edit_plan_path(plan)
    fill_in 'Nome', with: 'Básico'
    fill_in 'Preço padrão', with: '100.99'
    fill_in 'Permanência mínima', with: '-10.00'
    click_on 'Enviar'

    expect(page).to have_content('Permanência mínima deve ser maior que 0')
  end

  scenario 'and default price must be greater than 0' do
    user = create(:user)
    plan = create(:plan, name: 'Básico', default_price: '79.00',
                         minimum_period: 6)

    login_as(user, scope: :user)
    visit edit_plan_path(plan)
    fill_in 'Nome', with: 'Básico'
    fill_in 'Preço padrão', with: '-1'
    fill_in 'Permanência mínima', with: '2'
    click_on 'Enviar'

    expect(page).to have_content('Preço padrão deve ser maior que 0')
  end

  scenario 'and name must be unique' do
    user = create(:user)
    basic_plan = create(:plan, name: 'Básico', default_price: '79.00',
                               minimum_period: 6)
    create(:plan, name: 'Premium', default_price: '100.00',
                  minimum_period: 12)

    login_as(user, scope: :user)
    visit edit_plan_path(basic_plan)
    fill_in 'Nome', with: 'Premium'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end
end
