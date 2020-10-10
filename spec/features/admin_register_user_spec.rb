require 'rails_helper'

feature 'Admin creates user' do
  scenario 'successfully' do
    admin = create(:user)
    subsidiary = create(:subsidiary)
    subsidiary2 = create(:subsidiary)
    login_as admin

    visit root_path
    click_on 'Gerenciar funcionários'
    click_on 'Novo funcionário'
    fill_in 'Email', with: 'lorem@espertofit.com.br'
    fill_in 'Senha', with: '123456'
    fill_in 'Nome', with: 'Lorem da Silva'
    fill_in 'CPF', with: '704.341.182-30'
    fill_in 'Endereço', with: 'Rua Lorem Ipsum, 123'
    select 'Lorem1', from: 'Filial'
    select 'Funcionário', from: 'Permissão'
    click_on 'Criar'

    expect(page).to have_content('Usuário cadastrado com sucesso!')
    expect(page).to have_content('lorem@espertofit.com.br')
    expect(page).to have_content('Lorem da Silva')
    expect(page).to have_content('704.341.182-30')
    expect(page).to have_content('Rua Lorem Ipsum, 123')
    expect(page).to have_content('Lorem1')
    expect(page).to have_content('Funcionário')
  end
end
