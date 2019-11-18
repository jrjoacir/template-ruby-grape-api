# frozen_string_literal: true

RSpec.describe Services::Project::Get do
  context '#execute' do
    subject { Services::Project::Get.execute }

    context 'when is valid' do
      before { FactoryBot.create(:project) }

      it 'return an project model' do
        expect(subject).to be_an Models::Project
        expect(subject.id).to be_an Integer
      end
    end

    context 'when is invalid' do
      context 'when project notfound' do
        let(:error) { Errors::NotFound }
        let(:error_message) { 'Project does not exist' }

        it 'raise Errors::NotFound' do
          expect { subject }.to raise_error(error, error_message)
        end
      end
    end
  end
end
