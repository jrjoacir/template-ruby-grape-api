RSpec.describe Models::Healthcheck do
  context 'when healthcheck is OK' do
    let(:healthcheck) { Models::Healthcheck.new }
    let(:now) { Time.now }

    it 'healthcheck returns status OK' do
      expect(healthcheck.status).to eq 'OK'
      expect(healthcheck.status).to be_an String
    end

    it 'healthcheck returns date_time greater than now' do
      expect(now).to be < healthcheck.date_time
      expect(healthcheck.date_time).to be_an Time
    end
  end
end
