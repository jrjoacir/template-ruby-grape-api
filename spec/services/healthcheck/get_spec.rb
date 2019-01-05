RSpec.describe Services::Healthcheck::Get do
  before do
    expect(Commands::GetStatusDatabase).to receive(:execute).and_return(service_status)
  end

  subject { Services::Healthcheck::Get.execute }

  let(:service_status) { Models::ServiceStatus.new(status, duration, error) }
  let(:status) { 'OK' }
  let(:duration) { 1 }
  let(:error) { nil }

  context '#execute' do
    it 'returns a Models::Healthcheck class' do
      expect(subject).to be_an Models::Healthcheck
      expect(subject.services[:database]).to eq service_status
    end
  end
end
