require 'rails_helper'

feature 'User views enrollments' do
  scenario 'successfully' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    # TODO: Adicionar plano na matrícula
    enrollment1 = Enrollment.create!(customer_name: 'Lorem Name 1', customer_cpf: '159.422.547-88',
                                     valid_thru: Date.current + 1.year)
    enrollment2 = Enrollment.create!(customer_name: 'Lorem Name 2', customer_cpf: '901.516.426-64',
                                     valid_thru: Date.current + 6.months)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'

    expect(page).to have_content(enrollment1.token)
    expect(page).to have_content('Lorem Name 1')
    expect(page).to have_content('159.422.547-88')
    expect(page).to have_content(enrollment2.token)
    expect(page).to have_content('Lorem Name 2')
    expect(page).to have_content('901.516.426-64')
  end

  scenario 'and view details' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    enrollment = create(:enrollment)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'
    click_on enrollment.customer_name

    expect(page).to have_content(enrollment.customer_name)
    expect(page).to have_content(enrollment.customer_cpf)
    expect(page).to have_content(enrollment.valid_thru)
  end
end
