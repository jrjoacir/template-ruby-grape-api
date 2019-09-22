# frozen_string_literal: true

RSpec.describe Services::Healthcheck::Get do
  subject { Services::Healthcheck::Get.execute }

  context '#execute' do
    context 'when status services is OK' do
      before { expect(ORM::Database).to receive(:test!).and_return(nil) }

      it 'returns a Models::Healthcheck class' do
        expect(subject).to be_an Models::Healthcheck
      end

      it 'returns a list of Models::ServiceStatus' do
        expect(subject.services.first).to be_an Models::ServiceStatus
        expect(subject.services.class).to be Array
        expect(subject.services.count).to eq 1
      end

      it 'returns status services OK' do
        expect(subject.services.first.status).to eq 'OK'
      end
    end

    context 'when status services is NOT OK' do
      before { expect(ORM::Database).to receive(:test!).and_raise(StandardError) }

      it 'returns a Models::Healthcheck class' do
        expect(subject).to be_an Models::Healthcheck
      end

      it 'returns a list of Models::ServiceStatus' do
        expect(subject.services.first).to be_an Models::ServiceStatus
        expect(subject.services.class).to be Array
        expect(subject.services.count).to eq 1
      end

      it 'returns status services NOT_OK' do
        expect(subject.services.first.status).to eq 'NOT_OK'
      end
    end
  end
end
