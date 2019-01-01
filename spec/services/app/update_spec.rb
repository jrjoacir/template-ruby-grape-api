RSpec.describe Services::App::Update do
  context '#execute' do
    subject { Services::App::Update.execute(id, params) }
    let(:params) { { name: 'new name', description: 'new description' } }

    context 'when is valid' do
      let(:app) { FactoryBot.create(:app) }
      let(:id) { app.id }

      it 'return an app model' do
        expect(subject).to be_an Models::App
      end

      context 'when app parameters were changed' do
        it 'update app in database' do
          subject
          expect(Models::App[id]).to include params
        end
      end

      context 'when app parameters were not changed' do
        let(:params) { { name: app.name, description: app.description } }

        it 'get app from database' do
          subject
          expect(Models::App[id]).to include params
        end
      end
    end

    context 'when is invalid' do
      context 'when app not found' do
        let(:id) { 1 }

        it 'raise Errors::Business::NotFound' do
          expect{subject}.to raise_error(Errors::Business::NotFound, 'App does not exist')
        end
      end
    end
  end
end
