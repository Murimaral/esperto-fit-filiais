feature 'User cancels enrollment' do
  scenario 'successfully' do
    user = create(:user)
    subsidiary_plan = create(:subsidiary_plan)
    enrollment = create(:enrollment, customer_name: 'Frodo Baggins', customer_cpf: '901.516.426-64',
                                     subsidiary_plan: subsidiary_plan, status: :active)

    login_as user
    visit enrollment_path(enrollment)
    click_on 'Cancelar matrícula'

    expect(page).to have_content(enrollment.token)
    expect(page).to have_content('Frodo Baggins')
    expect(page).to have_content('901.516.426-64')
    expect(page).to have_content(enrollment.email)
    expect(page).to have_content(enrollment.subsidiary_plan.plan.name)
    expect(page).to have_content('Cancelada')
    expect(page).to_not have_link('Cancelar matrícula', href: cancel_enrollment_path(enrollment))
  end
end
