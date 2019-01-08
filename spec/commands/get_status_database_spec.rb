RSpec.describe Commands::GetStatusDatabase do
  subject { Commands::GetStatusDatabase.execute }

  context 'When database status is OK' do
    before do
      expect(ORM::Database.db).to receive(:run).with('select 1')
                                               .and_return(true)
    end

    it 'return an instance of Models::ServiceStatus class' do
      expect(subject).to be_an Models::ServiceStatus
    end

    it 'return duration > 0' do
      expect(subject.duration).to be > 0
    end

    it 'return status OK' do
      expect(subject.status).to eq 'OK'
    end

    it 'return error nil' do
      expect(subject.error).to be_nil
    end
  end

  context 'When database status is not OK' do
    before do
      expect(ORM::Database.db).to receive(:run).with('select 1')
                                               .and_raise(StandardError)
    end

    it 'return an instance of Models::ServiceStatus class' do
      expect(subject).to be_an Models::ServiceStatus
    end

    it 'return duration > 0' do
      expect(subject.duration).to be > 0
    end

    it 'return status NOT_OK' do
      expect(subject.status).to eq 'NOT_OK'
    end

    it 'return error StandardError' do
      expect(subject.error).to eq StandardError
    end
  end
end
