feature 'User associates plans to subsidiary' do
  scenario 'successfully' do
    user = create(:user)
    subsidiary = create(:subsidiary, name: 'Lorem Gym')
    create(:plan, name: 'Premium')

    login_as(user, scope: :user)
    visit subsidiary_path(subsidiary.id)
    click_on 'Cadastrar plano'
    select 'Premium', from: 'Plano'
    fill_in 'Preço final', with: '100.00'
    select 'Indisponível', from: 'Status'
    click_on 'Confirmar'

    expect(page).to have_content('Lorem Gym')
    expect(page).to have_content(subsidiary.cnpj)
    expect(page).to have_content(subsidiary.address)
    expect(page).to have_content('Premium')
    expect(page).to have_content('R$ 100,00')
    expect(page).to have_content('12 meses')
    expect(page).to have_content('Indisponível')
    expect(page).to have_content('Plano cadastrado com sucesso!')
  end

  scenario 'and must not be blank' do
    user = create(:user)
    subsidiary = create(:subsidiary, name: 'Lorem Gym')
    create(:plan, name: 'Premium')

    login_as(user, scope: :user)
    visit subsidiary_path(subsidiary.id)
    click_on 'Cadastrar plano'
    click_on 'Confirmar'

    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_content('Não foi possível cadastrar plano')
  end

  scenario 'and must be logged in' do
    subsidiary = create(:subsidiary, name: 'Lorem Gym')
    create(:plan, name: 'Premium')

    visit new_subsidiary_subsidiary_plan_path(subsidiary.id)

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  scenario 'and used plans must not show to select' do
    user = create(:user)
    plan = create(:plan, name: 'Básico')
    create(:plan, name: 'Premium')
    subsidiary = create(:subsidiary)
    create(:subsidiary_plan, subsidiary: subsidiary, plan: plan)

    login_as(user, scope: :user)
    visit new_subsidiary_subsidiary_plan_path(subsidiary.id)

    expect(page).to_not have_content('Básico')
    expect(page).to have_content('Premium')
  end
end
