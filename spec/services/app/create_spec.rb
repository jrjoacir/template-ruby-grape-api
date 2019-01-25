RSpec.describe Services::App::Create do
  context '#execute' do
    subject { Services::App::Create.execute(app_hash) }
    let(:app_hash) { { name: 'Name', description: 'Description' } }

    context 'when is valid' do
      it 'return an app model' do
        expect(subject).to be_an Models::App
        expect(subject.id).to be_an Integer
      end

      it 'create app in database' do
        expect(subject).to eq Models::App.last
      end
    end

    context 'when is invalid' do
      context 'when app already exists' do
        before { FactoryBot.create(:app) }
        let(:error) { Errors::AlreadyExist }
        let(:error_message) { 'App already exists' }

        it 'raise Errors::AlreadyExist' do
          expect { subject }.to raise_error(error, error_message)
        end
      end
    end
  end
end
