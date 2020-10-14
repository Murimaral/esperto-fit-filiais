describe 'Banned Customer' do
  let(:attributes) { attributes_for(:banned_customer) }
  it 'Must be authenticated to create' do
    enrollment = create(:enrollment)
    post enrollment_banned_customers(enrollment), params: { banned_customer: attributes }

    expect(response).to redirect_to(new_user_session_path)
  end
end
