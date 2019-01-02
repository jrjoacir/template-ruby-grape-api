RSpec.describe Endpoints::V1::App do
  context '#get' do
    subject { get('v1/app') }

    context 'when exist an app' do
      before { application }

      let(:application) { FactoryBot.create(:app) }
      let(:response_body) { application.to_hash.to_json }

      it 'return http status 200 - OK' do
        expect(subject.status).to eq 200
      end

      it 'return app response body' do
        expect(subject.body).to eq response_body
      end
    end

    context 'when no exist app' do
      let(:response_body) { { message: 'App does not exist' }.to_json }

      it 'return http status 404 - Notfound' do
        expect(subject.status).to eq 404
      end

      it 'return error response body' do
        expect(subject.body).to eq response_body
      end
    end
  end
end
