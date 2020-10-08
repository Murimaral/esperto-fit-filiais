describe 'Subsidiary plan authorization' do
  let(:attributes) { attributes_for(:subsidiary_plan) }
  it 'Must be authenticated to create' do
    subsidiary = create(:subsidiary)
    post "/subsidiaries/#{subsidiary.id}/subsidiary_plans", params: { subsidiary_plan: attributes }

    expect(response).to redirect_to(new_user_session_path)
  end
end
