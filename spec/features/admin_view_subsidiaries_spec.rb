require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'succesfully' do
    user = create(:user)
    subsidiary = create(:subsidiary, name: 'Osasco')
    subsidiary2 = create(:subsidiary, name: 'Pinheiros')
    subsidiary3 = create(:subsidiary, name: 'Vila Olímpia')

    login_as user
    visit root_path
    click_on 'Gerenciar filiais'

    expect(page).to have_content('Osasco')
    expect(page).to have_content('Pinheiros')
    expect(page).to have_content('Vila Olímpia')
    expect(page).to have_content(subsidiary.token)
    expect(page).to have_content(subsidiary2.token)
    expect(page).to have_content(subsidiary3.token)
  end

  scenario 'and view details' do
    user = create(:user)
    subsidiary = create(:subsidiary, name: 'Osasco')

    login_as user
    visit root_path
    click_on 'Gerenciar filiais'
    click_on 'Osasco'

    expect(page).to have_content(subsidiary.name)
    expect(page).to have_content(subsidiary.address)
    expect(page).to have_content(subsidiary.cnpj)
    expect(page).to have_content(subsidiary.token)
  end

  scenario 'and there are no subsidiaries' do
    user = create(:user, profile: nil)

    login_as user
    visit root_path
    click_on 'Gerenciar filiais'

    expect(page).to have_content('Não há filiais cadastradas')
  end

  scenario 'must be logged in to view index' do
    visit subsidiaries_path

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  scenario 'must be logged in to view details' do
    subsidiary = create(:subsidiary)
    visit subsidiary_path(subsidiary.id)

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  scenario 'and return to index from show' do
    user = create(:user)
    subsidiary = create(:subsidiary)

    login_as user
    visit root_path
    click_on 'Gerenciar filiais'
    click_on subsidiary.name
    click_on 'Voltar'

    expect(current_path).to eq(subsidiaries_path)
  end

  scenario 'and return to home page from index' do
    user = create(:user)
    create(:subsidiary)

    login_as user
    visit root_path
    click_on 'Gerenciar filiais'
    click_on 'Voltar'

    expect(current_path).to eq(root_path)
  end

  scenario 'and must be admin to view index' do
    user = create(:user, role: :employee)

    login_as user
    visit subsidiaries_path

    expect(current_path).to_not eq subsidiaries_path
    expect(current_path).to eq subsidiary_path(user.subsidiary)
  end
end
