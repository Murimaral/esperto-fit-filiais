feature 'Admin associates plans to subsidiary' do
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
end
