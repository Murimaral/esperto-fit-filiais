describe 'API banned cpf' do
  context 'GET api/v1/banned_customer/:cpf' do
    it 'successfully' do
      banned_customer = create(:banned_customer, cpf: '435.955.239-46')

      get api_v1_banned_customer_path(CPF.new(banned_customer.cpf).stripped)

      expect(response).to be_ok
    end

    it 'cpf is not found' do
      get api_v1_banned_customer_path('43595523946')

      expect(response).to be_not_found
    end

    it 'cpf is invalid' do
      get api_v1_banned_customer_path('12345')

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include('CPF inválido')
    end
  end
end
