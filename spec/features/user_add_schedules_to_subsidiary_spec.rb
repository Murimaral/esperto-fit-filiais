require 'rails_helper'

feature 'User adds schedule to subsidiary' do
  scenario 'successfully' do
    user = create(:user)
    subsidiary = create(:subsidiary)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar horários'
    click_on 'Clique aqui para defini-los agora'
    fill_in 'Segunda', with: '06:00 - 22:00'
    fill_in 'Terça', with: '06:00 - 22:00'
    fill_in 'Quarta', with: '06:00 - 22:00'
    fill_in 'Quinta', with: '06:00 - 22:00'
    fill_in 'Sexta', with: '06:00 - 22:00'
    fill_in 'Sábado', with: '06:00 - 18:00'
    fill_in 'Domingo', with: '08:00 - 12:00'
    fill_in 'Feriados', with: '08:00 - 12:00'
    click_on 'Enviar'

    expect(current_path).to eq(subsidiary_schedule_path(subsidiary))
    expect(page).to have_content('Horários definidos com sucesso')
    expect(page).to have_content('Segunda: 06:00 - 22:00')
    expect(page).to have_content('Sábado: 06:00 - 18:00')
    expect(page).to have_content('Domingo: 08:00 - 12:00')
    expect(page).to have_content('Feriados: 08:00 - 12:00')
  end

  scenario 'and does not fill a field' do
    user = create(:user)
    subsidiary = create(:subsidiary)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar horários'
    click_on 'Clique aqui para defini-los agora'
    fill_in 'Terça', with: '06:00 - 22:00'
    fill_in 'Quarta', with: '06:00 - 22:00'
    fill_in 'Quinta', with: '06:00 - 22:00'
    fill_in 'Sexta', with: '06:00 - 22:00'
    fill_in 'Sábado', with: '06:00 - 18:00'
    fill_in 'Domingo', with: '08:00 - 12:00'
    fill_in 'Feriados', with: '08:00 - 12:00'
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível definir horários')
    expect(page).to have_content('Segunda não pode ficar em branco')
  end

  scenario 'and already has a schedule' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    create(:schedule, monday: '06:00 - 22:30', subsidiary: subsidiary)

    login_as user
    visit subsidiary_schedule_path(subsidiary)

    expect(page).not_to have_content('Clique aqui para defini-los agora')
    expect(page).to have_content('06:00 - 22:30')
  end

  scenario 'and must be logged in' do
    subsidiary = create(:subsidiary)
    visit new_subsidiary_schedule_path(subsidiary)

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
