describe 'Schedule authorization' do
  let(:attributes) { attributes_for(:schedule) }
  it 'must be authenticated to create' do
    subsidiary = create(:subsidiary)
    post "/subsidiaries/#{subsidiary.id}/schedule", params: { subsidiary_plan: attributes }

    expect(response).to redirect_to(new_user_session_path)
  end
end
