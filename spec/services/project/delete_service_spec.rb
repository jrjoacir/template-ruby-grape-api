# frozen_string_literal: true

RSpec.describe Services::Project::Delete do
  context '#execute' do
    subject { Services::Project::Delete.execute(id) }

    context 'when is valid' do
      let(:id) { FactoryBot.create(:project).id }

      it 'return an project model' do
        expect(subject).to be_an Models::Project
      end

      it 'delete project from database' do
        subject
        expect(Models::Project[id]).to be_nil
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
