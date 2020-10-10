require 'rails_helper'

feature 'User bans customer' do
  scenario 'successfully' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    enrollment = create(:enrollment)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'
    click_on enrollment.customer_name
    click_on 'Banir cliente'
    fill_in 'Motivo', with: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, beatae.'
    click_on "Banir o cliente #{enrollment.customer_name}"

    expect(page).to have_content('Cliente banido com sucesso')
    expect(current_path).to eq(enrollments_path)
    expect(enrollment.reload).to be_banned
  end

  scenario 'and reason is not filled' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    enrollment = create(:enrollment)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'
    click_on enrollment.customer_name
    click_on 'Banir cliente'
    click_on "Banir o cliente #{enrollment.customer_name}"

    expect(page).to have_content('Falha ao banir cliente')
    expect(page).to have_content('Motivo não pode ficar em branco')
  end

  scenario 'must be logged in' do
    enrollment = create(:enrollment)

    visit new_enrollment_banned_customer_path(enrollment)

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
