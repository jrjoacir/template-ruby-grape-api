RSpec.describe Services::Healthcheck do
  context '#get' do
    subject { Services::Healthcheck.get }

    context 'when Healthcheck is OK' do
      it 'returns a Models::Healthcheck class' do
        expect(subject).to be_an Models::Healthcheck
      end
    end
  end
end
