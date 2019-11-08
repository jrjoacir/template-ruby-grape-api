# frozen_string_literal: true

RSpec.describe Endpoints::V1::Project::Put do
  before { put("v1/project/#{id}", params) }
  let(:params) { { name: 'new name', description: 'new description' } }

  context 'when exist an project' do
    let(:id) { FactoryBot.create(:project).id }
    let(:response_body) { { id: id }.merge(params).to_hash.to_json }

    it 'return http status 200 - OK' do
      expect(last_response.status).to eq 200
    end

    it 'return project response body' do
      expect(last_response.body).to eq response_body
    end
  end

  context 'when no exist project' do
    let(:id) { 1 }
    let(:response_body) { { message: 'Project does not exist' }.to_json }

    it 'return http status 404 - Notfound' do
      expect(last_response.status).to eq 404
    end

    it 'return error response body' do
      expect(last_response.body).to eq response_body
    end
  end
end
