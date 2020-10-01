require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    user = create(:user)
    create(:subsidiary, name: 'Osasco')
    create(:subsidiary, name: 'Pinheiros')
    create(:subsidiary, name: 'Vila Olímpia')

    login_as user
    visit root_path
    click_on 'Gerenciar filiais'

    expect(page).to have_content('Osasco')
    expect(page).to have_content('Pinheiros')
    expect(page).to have_content('Vila Olímpia')
  end

  scenario 'and there are no subsidiaries' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Gerenciar filiais'

    expect(page).to have_content('Não há filiais cadastradas')
  end
end
