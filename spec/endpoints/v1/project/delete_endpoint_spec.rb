# frozen_string_literal: true

RSpec.describe Endpoints::V1::Project::Delete do
  before { delete("v1/project/#{id}") }

  context 'when exist an project' do
    let(:id) { FactoryBot.create(:project).id }

    it 'return http status 204 - NoContent' do
      expect(last_response.status).to eq 204
    end

    it 'return empty response body' do
      expect(last_response.body).to be_empty
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
