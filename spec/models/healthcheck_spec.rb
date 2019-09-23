# frozen_string_literal: true

RSpec.describe Models::Healthcheck do
  context 'when healthcheck is initialized' do
    before do
      expect(Services::Healthcheck::Database).to receive(:execute).and_return(service)
    end
    let(:healthcheck) { Models::Healthcheck.new }
    let(:service) { Models::ServiceStatus.new(name, status, duration, error) }
    let(:name) { 'service-name' }
    let(:status) { 'OK' }
    let(:duration) { 1 }
    let(:error) { nil }

    it 'healthcheck returns date_time greater than now' do
      expect(healthcheck.date_time).to be < Time.now
      expect(healthcheck.date_time).to be_an Time
    end

    it 'database attribute contains a ServiceStatus Class' do
      expect(healthcheck.database).to be_an Models::ServiceStatus
      expect(healthcheck.database.status).to eq 'OK'
    end
  end
end
