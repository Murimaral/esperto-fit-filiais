require 'rails_helper'

describe 'Api enrollment' do
  describe 'POST api/v1/enrollments' do
    context 'with valid parameters' do
      let(:subsidiary_plan) { create(:subsidiary_plan) }
      let(:attributes) do
        { customer_name: 'Lorem', customer_cpf: '924.737.808-70', subsidiary_plan_id: subsidiary_plan.id,
          email: 'user@mail.com', price: 99.90 }
      end

      it 'returns 201 status' do
        post '/api/v1/enrollments', params: { enrollment: attributes }

        expect(response).to be_created
      end

      it 'creates an enrollment' do
        post '/api/v1/enrollments', params: { enrollment: attributes }

        enrollment = JSON.parse(response.body, symbolize_names: true)

        expect(enrollment[:id]).to be_present
        expect(enrollment[:customer_cpf]).to eq('924.737.808-70')
        expect(enrollment[:customer_name]).to eq('Lorem')
        expect(enrollment[:subsidiary_plan_id]).to eq(subsidiary_plan.id)
        expect(enrollment[:email]).to eq('user@mail.com')
        expect(enrollment[:price].to_f).to eq(attributes[:price])
        expect(enrollment[:valid_thru]).to be_present
        expect(enrollment[:status]).to eq(:active.to_s)
        expect(response).to be_created
        expect(Enrollment.all.count).to eq(1)
      end
    end

    context 'with invalid parameters' do
      it 'has no parameters' do
        post '/api/v1/enrollments'

        expect(response).to have_http_status(:precondition_failed)
        expect(response.body).to include('Parâmetros inválidos')
      end

      it 'with invalid params' do
        subsidiary_plan = create(:subsidiary_plan)
        attributes = { price: -10.00, customer_cpf: '1234311312', subsidiary_plan_id: subsidiary_plan.id,
                       name: 'Lorem', email: 'auehauhu' }
        post '/api/v1/enrollments', params: { enrollment: attributes }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Preço deve ser maior que 0')
        expect(response.body).to include('CPF do cliente não é válido')
        expect(response.body).to include('Email não é válido')
      end

      it 'with blank params' do
        post '/api/v1/enrollments', params: { enrollment: { foo: 'bar' } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Preço não pode ficar em branco')
        expect(response.body).to include('CPF do cliente não pode ficar em branco')
        expect(response.body).to include('Email não pode ficar em branco')
        expect(response.body).to include('Plano é obrigatório(a)')
        expect(response.body).to include('Nome do cliente não pode ficar em branco')
      end

      it 'with invalid subsidiary plan' do
        attributes = { customer_name: 'Lorem', customer_cpf: '924.737.808-70', subsidiary_plan_id: 0,
                       email: 'user@mail.com', price: 99.90 }

        post '/api/v1/enrollments', params: { enrollment: attributes }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('Plano é obrigatório(a)')
      end
    end
  end
end
