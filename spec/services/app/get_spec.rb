# frozen_string_literal: true

RSpec.describe Services::App::Get do
  context '#execute' do
    subject { Services::App::Get.execute }

    context 'when is valid' do
      before { FactoryBot.create(:app) }

      it 'return an app model' do
        expect(subject).to be_an Models::App
        expect(subject.id).to be_an Integer
      end
    end

    context 'when is invalid' do
      context 'when app notfound' do
        let(:error) { Errors::NotFound }
        let(:error_message) { 'App does not exist' }

        it 'raise Errors::NotFound' do
          expect { subject }.to raise_error(error, error_message)
        end
      end
    end
  end
end
