require 'rails_helper'

feature 'Admin view products' do
  scenario 'successfully' do
    user = create(:user)
    product = create(:product, name: 'Caneta EspertoFit')
    product2 = create(:product, name: 'Camiseta EspertoFit')
    product3 = create(:product, name: 'Chaveiro EspertoFit')

    login_as user
    visit root_path
    click_on 'Gerenciar produtos'

    expect(page).to have_content(product.name)
    expect(page).to have_content(product2.name)
    expect(page).to have_content(product3.name)
  end

  scenario 'and view details' do
    user = create(:user)
    product = create(:product, name: 'Caneta EspertoFit', min_price: 9.99)

    login_as user
    visit root_path
    click_on 'Gerenciar produtos'
    click_on 'Caneta EspertoFit'

    expect(page).to have_content(product.name)
    expect(page).to have_content(product.description)
    expect(page).to have_content('R$ 9,99')
  end

  scenario 'and there are no products' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Gerenciar produtos'

    expect(page).to have_content('Não há produtos cadastrados')
  end

  scenario 'and goes back to index from show' do
    user = create(:user)
    product = create(:product)

    login_as user
    visit root_path
    click_on 'Gerenciar produtos'
    click_on product.name
    click_on 'Voltar'

    expect(current_path).to eq(products_path)
  end

  scenario 'and goes to home from index' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Gerenciar produtos'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'and must be admin index' do
    user = create(:user, role: :employee)

    login_as user
    visit products_path

    expect(current_path).to eq subsidiary_path(user.subsidiary)
  end

  scenario 'and must be admin to view show' do
    user = create(:user, role: :employee)
    product = create(:product)

    login_as user
    visit product_path(product)

    expect(current_path).to eq subsidiary_path(user.subsidiary)
  end
end
