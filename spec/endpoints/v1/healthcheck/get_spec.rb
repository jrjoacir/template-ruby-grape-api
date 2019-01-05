RSpec.describe Endpoints::V1::Healthcheck::Get do
  before do
    expect(Commands::GetStatusDatabase).to receive(:execute).and_return(service_status)
    get("v1/healthcheck")
  end

  let(:duration) { 1 }
  let(:service_status) { Models::ServiceStatus.new(status, duration, error) }
  let(:healthcheck) { { now: Time.now, database: database_service } }
  let(:response_body) { healthcheck.to_json }

  context 'when healthcheck services is OK' do
    let(:status) { 'OK' }
    let(:error) { nil }

    let(:database_service) do
      {
        status: service_status.status,
        duration: service_status.duration
      }
    end

    it 'return http status 200 - OK' do
      expect(last_response.status).to eq 200
    end

    it 'return healthcheck response body' do
      expect(last_response.body).to eq response_body
    end
  end

  context 'when healthcheck services is NOT OK' do
    let(:status) { 'NOT_OK' }
    let(:error) { StandardError.new }

    let(:database_service) do
      {
        status: service_status.status,
        duration: service_status.duration,
        error: error
      }
    end

    it 'return http status 200 - OK' do
      expect(last_response.status).to eq 200
    end

    it 'return healthcheck response body' do
      expect(last_response.body).to eq response_body
    end
  end
end
