RSpec.describe Endpoints::V1::App::Put do
  before { put("v1/app/#{id}", params) }
  let(:params) { { name: 'new name', description: 'new description' } }

  context 'when exist an app' do
    let(:id) { FactoryBot.create(:app).id }
    let(:response_body) { {id: id}.merge(params).to_hash.to_json }

    it 'return http status 200 - OK' do
      expect(last_response.status).to eq 200
    end

    it 'return app response body' do
      expect(last_response.body).to eq response_body
    end
  end

  context 'when no exist app' do
    let(:id) { 1 }
    let(:response_body) { { message: 'App does not exist' }.to_json }

    it 'return http status 404 - Notfound' do
      expect(last_response.status).to eq 404
    end

    it 'return error response body' do
      expect(last_response.body).to eq response_body
    end
  end
end
