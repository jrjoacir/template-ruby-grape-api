# frozen_string_literal: true

RSpec.describe Models::App do
  context '#initialize' do
    let(:app) { Models::App.new(app_hash) }
    let(:app_hash) { { name: 'App', description: 'Description' } }

    it 'app returns name' do
      expect(app.name).to eq app_hash[:name]
    end

    it 'app returns description' do
      expect(app.description).to eq app_hash[:description]
    end
  end
end
