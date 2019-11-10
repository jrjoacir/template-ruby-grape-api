# frozen_string_literal: true

RSpec.describe Endpoints::V1::Project::Get do
  subject { get('v1/projects') }

  context 'when exist an project' do
    before { project }

    let(:project) { FactoryBot.create(:project) }
    let(:response_body) { project.to_hash.to_json }

    it 'return http status 200 - OK' do
      expect(subject.status).to eq 200
    end

    it 'return project response body' do
      expect(subject.body).to eq response_body
    end
  end

  context 'when no exist project' do
    let(:response_body) { { message: 'Project does not exist' }.to_json }

    it 'return http status 404 - Notfound' do
      expect(subject.status).to eq 404
    end

    it 'return error response body' do
      expect(subject.body).to eq response_body
    end
  end
end
