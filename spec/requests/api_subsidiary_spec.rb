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
end
