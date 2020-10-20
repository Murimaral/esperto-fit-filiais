require 'rails_helper'

feature 'User searches enrollments' do
  scenario 'and find exact match by token' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    enrollment1 = create(:enrollment, customer_name: 'Lorem Name 1', customer_cpf: '159.422.547-88',
                                      valid_thru: Date.current + 1.year)
    enrollment2 = create(:enrollment, customer_name: 'Lorem Name 2', customer_cpf: '901.516.426-64',
                                      valid_thru: Date.current + 6.months)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'
    fill_in 'Busca de matrículas', with: enrollment1.token
    click_on 'Buscar'

    expect(page).to have_content(enrollment1.token)
    expect(page).to have_content(enrollment1.customer_name)
    expect(page).to have_content(enrollment1.customer_cpf)
    expect(page).not_to have_content(enrollment2.token)
    expect(page).not_to have_content(enrollment2.customer_name)
    expect(page).not_to have_content(enrollment2.customer_cpf)
  end

  scenario 'and find exact match by name' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    enrollment1 = create(:enrollment, customer_name: 'Lorem Name 1', customer_cpf: '159.422.547-88',
                                      valid_thru: Date.current + 1.year)
    enrollment2 = create(:enrollment, customer_name: 'Lorem Name 2', customer_cpf: '901.516.426-64',
                                      valid_thru: Date.current + 6.months)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'
    fill_in 'Busca de matrículas', with: enrollment1.customer_name
    click_on 'Buscar'

    expect(page).to have_content(enrollment1.token)
    expect(page).to have_content(enrollment1.customer_name)
    expect(page).to have_content(enrollment1.customer_cpf)
    expect(page).not_to have_content(enrollment2.token)
    expect(page).not_to have_content(enrollment2.customer_name)
    expect(page).not_to have_content(enrollment2.customer_cpf)
  end

  scenario 'and find exact match by cpf' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    enrollment1 = create(:enrollment, customer_name: 'Lorem Name 1', customer_cpf: '159.422.547-88',
                                      valid_thru: Date.current + 1.year)
    enrollment2 = create(:enrollment, customer_name: 'Lorem Name 2', customer_cpf: '901.516.426-64',
                                      valid_thru: Date.current + 6.months)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'
    fill_in 'Busca de matrículas', with: enrollment1.customer_cpf
    click_on 'Buscar'

    expect(page).to have_content(enrollment1.token)
    expect(page).to have_content(enrollment1.customer_name)
    expect(page).to have_content(enrollment1.customer_cpf)
    expect(page).not_to have_content(enrollment2.token)
    expect(page).not_to have_content(enrollment2.customer_name)
    expect(page).not_to have_content(enrollment2.customer_cpf)
  end

  scenario 'and finds nothing' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    enrollment1 = create(:enrollment, customer_name: 'Lorem Name 1', customer_cpf: '159.422.547-88',
                                      valid_thru: Date.current + 1.year)
    enrollment2 = create(:enrollment, customer_name: 'Lorem Name 2', customer_cpf: '901.516.426-64',
                                      valid_thru: Date.current + 6.months)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'
    fill_in 'Busca de matrículas', with: 'RTYU'
    click_on 'Buscar'

    expect(page).not_to have_content(enrollment1.token)
    expect(page).not_to have_content(enrollment2.token)
  end
end
