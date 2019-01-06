RSpec.describe Commands::GetStatusDatabase do
  subject { Commands::GetStatusDatabase.execute }

  context 'When database status is OK' do
    before do
      expect(ORM::Database.db).to receive(:run).with('select 1')
                                               .and_return(true)
    end

    it 'return an instance of Models::ServiceStatus class with Status OK' do
      expect(subject).to be_an Models::ServiceStatus
      expect(subject.status).to eq 'OK'
    end
  end

  context 'When database status is not OK' do
    before do
      expect(ORM::Database.db).to receive(:run).with('select 1')
                                               .and_raise(StandardError)
    end

    it 'return an instance of Models::ServiceStatus class with Status NOT_OK' do
      expect(subject).to be_an Models::ServiceStatus
      expect(subject.status).to eq 'NOT_OK'
    end
  end
end
