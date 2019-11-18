# frozen_string_literal: true

RSpec.describe Models::Project do
  context '#initialize' do
    let(:project) { Models::Project.new(project_hash) }
    let(:project_hash) { { name: 'Project', description: 'Description' } }

    it 'project returns name' do
      expect(project.name).to eq project_hash[:name]
    end

    it 'project returns description' do
      expect(project.description).to eq project_hash[:description]
    end
  end
end
