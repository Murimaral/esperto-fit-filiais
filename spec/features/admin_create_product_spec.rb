require 'rails_helper'

feature 'Admin create product' do
  scenario 'successfully' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Gerenciar produtos'
    click_on 'Adicionar produto'
    fill_in 'Nome', with: 'Camiseta EspertoFit'
    fill_in 'Descrição', with: 'Camiseta EspertoFit Preta Tamanho G'
    fill_in 'Preço mínimo', with: 30
    click_on 'Enviar'

    expect(current_path).to eq(product_path(Product.last.id))
    expect(page).to have_content('Produto criado com sucesso!')
    expect(page).to have_content('Camiseta EspertoFit')
    expect(page).to have_content('Camiseta EspertoFit Preta Tamanho G')
    expect(page).to have_content('R$ 30,00')
  end

  scenario 'must be logged in' do
    visit new_product_path

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  scenario 'must fill in all fields' do
    user = create(:user)

    login_as user
    visit new_product_path
    click_on 'Enviar'

    expect(page).to have_content('O produto não foi criado.')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Preço mínimo não pode ficar em branco')
  end
end
