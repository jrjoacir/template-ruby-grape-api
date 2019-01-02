RSpec.describe Endpoints::V1::Healthcheck do
  before { get("v1/healthcheck") }
  let(:healthcheck) { { status: 'OK', now: Time.now} }
  let(:response_body) { healthcheck.to_json }

  context 'when healthcheck is OK' do
    it 'return http status 200 - OK' do
      expect(last_response.status).to eq 200
    end

    it 'return healthcheck response body' do
      expect(last_response.body).to eq response_body
    end
  end
end
