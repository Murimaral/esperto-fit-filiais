describe 'Plan authorization' do
  let(:attributes) { attributes_for(:plan) }
  it 'must be authenticated to create' do
    post '/plans', params: { plan: attributes }

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'must be admin to create' do
    user = create(:user, role: :employee)

    login_as user
    post '/plans', params: { plan: attributes }

    expect(response).to redirect_to(subsidiary_path(user.subsidiary))
  end

  it 'must be authenticated to edit' do
    plan = create(:plan)
    
    patch "/plans/#{plan.id}", params: { plan: attributes }

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'must be admin to edit' do
    user = create(:user, role: :employee)
    plan = create(:plan)

    login_as user
    patch "/plans/#{plan.id}", params: { plan: attributes }

    expect(response).to redirect_to(subsidiary_path(user.subsidiary))
  end
end
