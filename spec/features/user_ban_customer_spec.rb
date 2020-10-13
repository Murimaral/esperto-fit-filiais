require 'rails_helper'

feature 'User bans customer' do
  include ActiveSupport::Testing::TimeHelpers

  scenario 'successfully' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    enrollment = create(:enrollment)
    allow_any_instance_of(BannedCustomer).to receive(:send_data_to_customers_api).and_return(true)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'
    click_on enrollment.customer_name
    click_on 'Banir cliente'
    fill_in 'Motivo', with: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, beatae.'
    travel_to Time.zone.local(2020, 11, 24, 12, 30, 44) do
      click_on "Banir o cliente #{enrollment.customer_name}"
    end

    expect(page).to have_content('Cliente banido com sucesso')
    expect(page).to have_content('Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, beatae.')
    expect(page).to have_content(enrollment.customer_cpf)
    expect(page).to have_content('24/11/2020 às 12:30')
    expect(page).to have_content(user.email)
    expect(enrollment.reload).to be_banned
  end

  scenario 'must be logged in' do
    enrollment = create(:enrollment)

    visit new_enrollment_banned_customer_path(enrollment)

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
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

  scenario 'and fails to send data to customers api' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    enrollment = create(:enrollment)
    allow_any_instance_of(BannedCustomer).to receive(:send_data_to_customers_api).and_return(false)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'
    click_on enrollment.customer_name
    click_on 'Banir cliente'
    fill_in 'Motivo', with: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, beatae.'
    click_on "Banir o cliente #{enrollment.customer_name}"

    expect(page).to have_content('Falha ao banir cliente. Não foi possível comunicar o sistema de clientes. '\
                                 'Tente novamente mais tarde')
  end
end
