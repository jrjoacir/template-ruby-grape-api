# frozen_string_literal: true

RSpec.describe Endpoints::V1::Project::Post do
  subject { post('v1/project', params) }
  let(:params) { { name: 'new name', description: 'new description' } }

  context 'when exist an project' do
    before { FactoryBot.create(:project) }
    let(:response_body) { { message: 'Project already exists' }.to_json }

    it 'return http status 409 - Conflict' do
      expect(subject.status).to eq 409
    end

    it 'return error response body' do
      expect(subject.body).to eq response_body
    end
  end

  context 'when no exist project' do
    let(:response_body) { Models::Project.last.to_hash.to_json }

    it 'return http status 201 - Created' do
      expect(subject.status).to eq 201
    end

    it 'return project response body' do
      expect(subject.body).to eq response_body
    end
  end
end
