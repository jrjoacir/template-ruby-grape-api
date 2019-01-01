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
        it 'raise Errors::Business::NotFound' do
          expect{subject}.to raise_error(Errors::Business::NotFound, 'App does not exist')
        end
      end
    end
  end
end
