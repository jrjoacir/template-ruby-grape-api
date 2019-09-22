# frozen_string_literal: true

RSpec.describe Models::Healthcheck do
  context 'when healthcheck is initialized' do
    let(:healthcheck) { Models::Healthcheck.new(services) }
    let(:services) { Models::ServiceStatus.new(name, status, duration, error) }
    let(:name) { 'service-name' }
    let(:status) { 'OK' }
    let(:duration) { 1 }
    let(:error) { nil }
    let(:now) { Time.now }

    it 'healthcheck returns date_time greater than now' do
      expect(now).to be < healthcheck.date_time
      expect(healthcheck.date_time).to be_an Time
    end

    it 'services attribute contains a ServiceStatus Class' do
      expect(healthcheck.services).to be_an Models::ServiceStatus
      expect(healthcheck.services.status).to eq 'OK'
    end
  end
end
