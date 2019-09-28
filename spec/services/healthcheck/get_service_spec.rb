# frozen_string_literal: true

RSpec.describe Services::Healthcheck::Get do
  subject { Services::Healthcheck::Get.execute }

  context '#execute' do
    context 'when database status service is OK' do
      before { expect(ORM::Database).to receive(:test!).and_return(nil) }

      it 'returns a Models::Healthcheck class' do
        expect(subject).to be_an Models::Healthcheck
      end

      it 'returns a Models::ServiceStatus' do
        expect(subject.database.class).to be Models::ServiceStatus
      end

      it 'returns database status service OK' do
        expect(subject.database.status).to eq 'OK'
      end
    end

    context 'when status services is NOT OK' do
      before { expect(ORM::Database).to receive(:test!).and_raise(StandardError) }

      it 'returns a Models::Healthcheck class' do
        expect(subject).to be_an Models::Healthcheck
      end

      it 'returns a Models::ServiceStatus' do
        expect(subject.database.class).to be Models::ServiceStatus
      end

      it 'returns database status service NOT_OK' do
        expect(subject.database.status).to eq 'NOT_OK'
      end
    end
  end
end
