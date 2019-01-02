RSpec.describe Endpoints::V1::App::Post do
  subject { post('v1/app', params) }
  let(:params) { { name: 'new name', description: 'new description' } }

  context 'when exist an app' do
    before { FactoryBot.create(:app) }
    let(:response_body) { { message: 'App already exists' }.to_json }

    it 'return http status 409 - Conflict' do
      expect(subject.status).to eq 409
    end

    it 'return error response body' do
      expect(subject.body).to eq response_body
    end
  end

  context 'when no exist app' do
    let(:response_body) { Models::App.last.to_hash.to_json }

    it 'return http status 201 - Created' do
      expect(subject.status).to eq 201
    end

    it 'return app response body' do
      expect(subject.body).to eq response_body
    end
  end
end
