describe 'Plan authorization' do
  let(:attributes) { attributes_for(:plan) }
  it 'Must be authenticated to create' do
    post '/plans', params: { plan: attributes }

    expect(response).to redirect_to(new_user_session_path)
  end
end
