require 'rails_helper'

feature 'User edits subsidiary schedule' do
  scenario 'successfully' do
    user = create(:user, role: :employee)
    subsidiary = create(:subsidiary)
    create(:schedule, subsidiary: subsidiary)

    login_as user
    visit subsidiary_schedule_path(subsidiary)
    click_on 'Alterar horários'
    fill_in 'Segunda', with: '04:00 - 23:00'
    fill_in 'Feriados', with: 'Fechado'
    click_on 'Enviar'

    expect(page).to have_content('Horários alterados com sucesso')
    expect(page).to have_content('04:00 - 23:00')
    expect(page).to have_content('Fechado')
  end

  scenario 'and leaves a blank field' do
    user = create(:user, role: :employee)
    subsidiary = create(:subsidiary)
    create(:schedule, subsidiary: subsidiary)

    login_as user
    visit subsidiary_schedule_path(subsidiary)
    click_on 'Alterar horários'
    fill_in 'Segunda', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível alterar horários')
    expect(page).to have_content('Segunda não pode ficar em branco')
  end

  scenario 'and there is no defined schedule' do
    user = create(:user, role: :employee)
    subsidiary = create(:subsidiary)

    login_as user
    visit edit_subsidiary_schedule_path(subsidiary)

    expect(current_path).to eq(subsidiary_schedule_path(subsidiary))
    expect(page).not_to have_content('Alterar horários')
    expect(page).to have_content('Ainda não há horários cadastrados na sua filial')
  end

  scenario 'and must be logged in' do
    subsidiary = create(:subsidiary)
    visit edit_subsidiary_schedule_path(subsidiary)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
