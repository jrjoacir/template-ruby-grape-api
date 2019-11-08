# frozen_string_literal: true

RSpec.describe Services::Project::Update do
  context '#execute' do
    subject { Services::Project::Update.execute(id, params) }
    let(:params) { { name: 'new name', description: 'new description' } }

    context 'when is valid' do
      let(:project) { FactoryBot.create(:project) }
      let(:id) { project.id }

      it 'return an project model' do
        expect(subject).to be_an Models::Project
      end

      context 'when project parameters were changed' do
        it 'update project in database' do
          subject
          expect(Models::Project[id]).to include params
        end
      end

      context 'when project parameters were not changed' do
        let(:params) { { name: project.name, description: project.description } }

        it 'get project from database' do
          subject
          expect(Models::Project[id]).to include params
        end
      end
    end

    context 'when is invalid' do
      context 'when project not found' do
        let(:id) { 1 }
        let(:error) { Errors::NotFound }
        let(:error_message) { 'Project does not exist' }

        it 'raise Errors::NotFound' do
          expect { subject }.to raise_error(error, error_message)
        end
      end
    end
  end
end
