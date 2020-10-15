feature 'User sign in' do
  scenario 'and goes to new session path' do
    visit root_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    user = create(:user, email: 'teste@espertofit.com.br', role: :employee)

    visit root_path
    fill_in 'Email', with: 'teste@espertofit.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    expect(current_path).to eq subsidiary_path(user.subsidiary)
    expect(page).to have_content('Login efetuado com sucesso')
  end

  scenario 'successfully as admin' do
    create(:user, email: 'teste@espertofit.com.br', password: '123456', role: :admin)

    visit root_path
    fill_in 'Email', with: 'teste@espertofit.com.br'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_content('EspertoFit Dashboard')
  end

  scenario 'and sign out' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Sair'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, efetue login ou registre-se.'
    expect(page).to have_button 'Entrar'
    expect(page).not_to have_content 'Sair'
  end

  scenario 'and must fill all blanks' do
    visit root_path
    click_on 'Entrar'

    expect(page).to have_content('Email ou senha inválida')
  end

  scenario 'and do not show sign up' do
    visit root_path

    expect(page).not_to have_content('Sign up')
  end
end
