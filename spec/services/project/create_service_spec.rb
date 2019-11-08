# frozen_string_literal: true

RSpec.describe Services::Project::Create do
  context '#execute' do
    subject { Services::Project::Create.execute(project_hash) }
    let(:project_hash) { { name: 'Name', description: 'Description' } }

    context 'when is valid' do
      it 'return an project model' do
        expect(subject).to be_an Models::Project
        expect(subject.id).to be_an Integer
      end

      it 'create project in database' do
        expect(subject).to eq Models::Project.last
      end
    end

    context 'when is invalid' do
      context 'when project already exists' do
        before { FactoryBot.create(:project) }
        let(:error) { Errors::AlreadyExist }
        let(:error_message) { 'Project already exists' }

        it 'raise Errors::AlreadyExist' do
          expect { subject }.to raise_error(error, error_message)
        end
      end
    end
  end
end
