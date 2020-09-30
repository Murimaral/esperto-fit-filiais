require 'rails_helper'

feature 'Admin adds schedule to subsidiary' do
  scenario 'successfully' do
    user = create(:user)
    subsidiary = create(:subsidiary)
  
    login_as user
    visit subsidiary_path(subsidiary.id)
    click_on 'Gerenciar Horários'
    fill_in 'Segunda', with: '06:00 - 22:00'
    fill_in 'Terça', with: '06:00 - 22:00'
    fill_in 'Quarta', with: '06:00 - 22:00'
    fill_in 'Quinta', with: '06:00 - 22:00'
    fill_in 'Sexta', with: '06:00 - 22:00'
    fill_in 'Sábado', with: '06:00 - 18:00'
    fill_in 'Domingo', with: '08:00 - 12:00'
    fill_in 'Feriados', with: '08:00 - 12:00'
    click_on 'Enviar'

    expect(current_path).to eq(subsidiary_path(subsidiary.id))
    expect(page).to have_content('Horários atualizados com sucesso')
    expect(page).to have_content('Segunda: 06:00 - 22:00')
    expect(page).to have_content('Sábado: 06:00 - 18:00')
    expect(page).to have_content('Domingo: 08:00 - 12:00')
    expect(page).to have_content('Feriados: 08:00 - 12:00')
  end

  xscenario 'and already has a schedule' # vai pro edit
end
