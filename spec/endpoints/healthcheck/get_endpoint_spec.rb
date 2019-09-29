# frozen_string_literal: true

RSpec.describe Endpoints::Healthcheck::Get do
  before do
    expect(Services::Healthcheck::Database).to receive(:execute).and_return(service_status)
    get('healthcheck')
  end

  let(:duration) { 1 }
  let(:service_status) { Models::ServiceStatus.new(name, status, duration, error) }
  let(:healthcheck) { { now: Time.now, database: database_service } }
  let(:response_body) { healthcheck.to_json }
  let(:response_service) { JSON.parse(last_response.body).deep_symbolize_keys[:database] }
  let(:name) { 'Database' }
  let(:database_service) do
    {
      name: name,
      status: service_status.status,
      duration: service_status.duration
    }
  end

  context 'when healthcheck services is OK' do
    let(:status) { 'OK' }
    let(:error) { nil }

    it 'return http status 200 - OK' do
      expect(last_response.status).to eq 200
    end

    it 'return healthcheck response body' do
      expect(response_service).to eq database_service
      expect(JSON.parse(last_response.body)['now']).to be < Time.now
    end
  end

  context 'when healthcheck services is NOT OK' do
    let(:status) { 'NOT_OK' }
    let(:error) { 'StandardError' }

    let(:database_service) do
      {
        name: name,
        status: service_status.status,
        duration: service_status.duration,
        error: error
      }
    end

    it 'return http status 200 - OK' do
      expect(last_response.status).to eq 200
    end

    it 'return healthcheck response body' do
      expect(response_service).to eq database_service
      expect(JSON.parse(last_response.body)['now']).to be < Time.now
    end
  end
end
