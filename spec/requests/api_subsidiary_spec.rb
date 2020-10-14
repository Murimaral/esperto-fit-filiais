require 'rails_helper'

describe 'Api subsidiary' do
  context 'GET api/v1/subsidiaries' do
    it 'successfully' do
      subsidiaries = create_list(:subsidiary, 2)

      get api_v1_subsidiaries_path

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(response.body).to eq subsidiaries.to_json
    end

    it 'empty subsidiaries' do
      get api_v1_subsidiaries_path

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json).to be_empty
    end
  end

  context 'GET /api/v1/subsidiaries/:id' do
    context 'record exists' do
      let(:subsidiary) { create(:subsidiary) }
      let(:plan) { create(:plan) }
      let(:subsidiary_plan) { create(:subsidiary_plan, subsidiary: subsidiary) }

      it 'return 200 status' do
        get "/api/v1/subsidiaries/#{subsidiary.id}"

        expect(response).to be_ok
      end

      it 'returns subsidiary' do
        plan = create(:plan, name: 'Premium')
        create(:subsidiary_plan, subsidiary: subsidiary, plan: plan, final_price: 99.99, status: :available)

        get "/api/v1/subsidiaries/#{subsidiary.id}"
        response_json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_ok
        expect(response_json[:name]).to eq(subsidiary.name)
        expect(response_json[:id]).to eq(subsidiary.id)
        expect(response_json[:subsidiary_plans][0][:name]).to eq('Premium')
        expect(response_json[:subsidiary_plans][0][:final_price]).to eq('99.99')
        expect(response_json[:subsidiary_plans][0][:status]).to eq('available')
      end
    end

    context 'record does not exist' do
      it 'return 404 status' do
        get '/api/v1/subsidiaries/000'

        expect(response).to be_not_found
      end

      it 'return not found message' do
        get '/api/v1/subsidiaries/000'

        expect(response.body).to include('Filial não encontrada')
      end
    end
  end
end
