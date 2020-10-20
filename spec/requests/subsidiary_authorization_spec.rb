describe 'Subsidiary authorization' do
  let(:attributes) { attributes_for(:subsidiary) }
  it 'must be authenticated to create' do
    post '/subsidiaries', params: { subsidiary: attributes }

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'must be admin to create' do
    user = create(:user, role: :employee)

    login_as user
    post '/subsidiaries', params: { subsidiary: attributes }

    expect(response).to redirect_to(subsidiary_path(user.subsidiary))
  end
end
