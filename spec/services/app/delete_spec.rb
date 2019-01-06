RSpec.describe Services::App::Delete do
  context '#execute' do
    subject { Services::App::Delete.execute(id) }

    context 'when is valid' do
      let(:id) { FactoryBot.create(:app).id }

      it 'return an app model' do
        expect(subject).to be_an Models::App
      end

      it 'delete app from database' do
        subject
        expect(Models::App[id]).to be_nil
      end
    end

    context 'when is invalid' do
      context 'when app not found' do
        let(:id) { 1 }
        let(:error) { Errors::Business::NotFound }
        let(:error_message) { 'App does not exist' }

        it 'raise Errors::Business::NotFound' do
          expect { subject }.to raise_error(error, error_message)
        end
      end
    end
  end
end
