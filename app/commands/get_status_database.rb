# frozen_string_literal: true

module Commands
  module GetStatusDatabase
    def self.execute
      start = Time.now

      begin
        ORM::Database.db.run('select 1')
        Models::ServiceStatus.new('OK', Time.now - start, nil)
      rescue StandardError => error
        Models::ServiceStatus.new('NOT_OK', Time.now - start, error.class)
      end
    end
  end
end
