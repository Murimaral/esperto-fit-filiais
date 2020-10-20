feature 'User associates products to subsidiary' do
  scenario 'successfully' do
    user = create(:user)
    subsidiary = create(:subsidiary, name: 'Lorem Gym')
    create(:product, name: 'Camiseta', description: 'Camiseta masculina esportiva')

    login_as(user, scope: :user)
    visit subsidiary_path(subsidiary.id)
    click_on 'Cadastrar produto'
    select 'Camiseta', from: 'Produto'
    fill_in 'Preço final', with: '100.00'
    select 'Indisponível', from: 'Status'
    click_on 'Confirmar'

    expect(page).to have_content('Lorem Gym')
    expect(page).to have_content(subsidiary.cnpj)
    expect(page).to have_content(subsidiary.address)
    expect(page).to have_content('Camiseta')
    expect(page).to have_content('Camiseta masculina esportiva')
    expect(page).to have_content('R$ 100,00')
    expect(page).to have_content('Indisponível')
    expect(page).to have_content('Produto cadastrado com sucesso!')
  end

  scenario 'and must not be blank' do
    user = create(:user)
    subsidiary = create(:subsidiary, name: 'Lorem Gym')
    create(:product, name: 'Camiseta')

    login_as(user, scope: :user)
    visit subsidiary_path(subsidiary.id)
    click_on 'Cadastrar produto'
    click_on 'Confirmar'

    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_content('Não foi possível cadastrar produto')
  end

  scenario 'and must be logged in' do
    subsidiary = create(:subsidiary, name: 'Lorem Gym')
    create(:product, name: 'Camiseta')

    visit new_subsidiary_subsidiary_product_path(subsidiary.id)

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  scenario 'and used products must not show to select' do
    user = create(:user)
    product = create(:product, name: 'Camiseta')
    create(:product, name: 'Garrafa')
    subsidiary = create(:subsidiary)
    create(:subsidiary_product, subsidiary: subsidiary, product: product)

    login_as(user, scope: :user)
    visit new_subsidiary_subsidiary_product_path(subsidiary.id)

    expect(page).to_not have_content('Camiseta')
    expect(page).to have_content('Garrafa')
  end
end
