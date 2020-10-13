require 'rails_helper'

feature 'User views enrollments' do
  scenario 'successfully' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    subsidiary_plan = create(:subsidiary_plan, subsidiary: subsidiary)
    enrollment1 = create(:enrollment, customer_name: 'Lorem Name 1', customer_cpf: '159.422.547-88',
                                      valid_thru: Date.current + 1.year, subsidiary_plan: subsidiary_plan)
    enrollment2 = create(:enrollment, customer_name: 'Lorem Name 2', customer_cpf: '901.516.426-64',
                                      valid_thru: Date.current + 6.months, subsidiary_plan: subsidiary_plan)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'

    expect(page).to have_content(enrollment1.token)
    expect(page).to have_content('Lorem Name 1')
    expect(page).to have_content('159.422.547-88')
    expect(page).to have_content(enrollment2.token)
    expect(page).to have_content('Lorem Name 2')
    expect(page).to have_content('901.516.426-64')
    expect(page).to_not have_css('h3', text: 'Não há matriculas cadastradas.')
  end

  scenario 'and view details' do
    user = create(:user)
    subsidiary = create(:subsidiary)
    subsidiary_plan = create(:subsidiary_plan, subsidiary: subsidiary)
    enrollment = create(:enrollment, status: :active, price: 98.90, subsidiary_plan: subsidiary_plan)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'
    click_on enrollment.customer_name

    expect(page).to have_content(enrollment.token)
    expect(page).to have_content(enrollment.customer_name)
    expect(page).to have_content(enrollment.customer_cpf)
    expect(page).to have_content(enrollment.valid_thru)
    expect(page).to have_content(enrollment.email)
    expect(page).to have_content('Ativa')
    expect(page).to have_content(enrollment.subsidiary_plan.plan.name)
    expect(page).to have_content('R$ 98,90')
  end

  scenario 'and there is no enrollment registered' do
    user = create(:user)
    subsidiary = create(:subsidiary)

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'

    expect(page).to have_css('h3', text: 'Não há matriculas cadastradas.')
  end

  scenario 'and must be logged in to view index' do
    subsidiary = create(:subsidiary)
    visit subsidiary_enrollments_path(subsidiary)

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  scenario 'and must be logged in to view details' do
    enrollment = create(:enrollment)
    subsidiary = create(:subsidiary)

    visit subsidiary_enrollment_path(subsidiary.id, enrollment.id)

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end

  scenario 'and must view only enrollments from his subsidiary' do
    user = create(:user, role: :employee)
    subsidiary = create(:subsidiary)
    subsidiary_plan = create(:subsidiary_plan, subsidiary: subsidiary)
    create(:profile, user: user, subsidiary: subsidiary)
    create(:enrollment, customer_name: 'Lorem Name 1', subsidiary_plan: subsidiary_plan)
    create(:enrollment, customer_name: 'Lorem Name 2', subsidiary_plan: subsidiary_plan)
    create(:enrollment, customer_name: 'Lorem Name 3')

    login_as user
    visit subsidiary_path(subsidiary)
    click_on 'Gerenciar matrículas'

    expect(page).to have_content('Lorem Name 1')
    expect(page).to have_content('Lorem Name 2')
    expect(page).to_not have_content('Lorem Name 3')
  end
end
