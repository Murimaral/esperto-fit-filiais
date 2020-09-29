require 'rails_helper'

feature 'Admin creates subsidiary' do
  scenario 'successfully' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Gerenciar filiais'
    click_on 'Adicionar filial'
    fill_in 'Nome', with: 'Vila Olímpia'
    fill_in 'Endereço', with: 'R. Lorem Ipsum, 123 - Vila Olímpia - São Paulo/SP'
    fill_in 'CNPJ', with: '10.813.643/1863-76'
    click_on 'Enviar'

    expect(page).to have_content('Filial criada com sucesso!')
    expect(page).to have_content('Vila Olímpia')
    expect(page).to have_content('10.813.643/1863-76')
    expect(page).to have_content('R. Lorem Ipsum, 123 - Vila Olímpia - São Paulo/SP')
    expect(Subsidiary.all.count).to eq(1)
  end

  scenario 'must fill in all fields' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Gerenciar filiais'
    click_on 'Adicionar filial'
    click_on 'Enviar'

    expect(page).to have_content('A filial não foi criada.')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(Subsidiary.all.count).to eq(0)
  end

  scenario 'must fill a valid CNPJ' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Gerenciar filiais'
    click_on 'Adicionar filial'
    fill_in 'Nome', with: 'Vila Olímpia'
    fill_in 'Endereço', with: 'R. Lorem Ipsum, 123 - Vila Olímpia - São Paulo/SP'
    fill_in 'CNPJ', with: '10.000.643/1863-76'
    click_on 'Enviar'

    expect(page).to have_content('A filial não foi criada.')
    expect(page).to have_content('CNPJ não é válido')
    expect(Subsidiary.all.count).to eq(0)
  end
end
