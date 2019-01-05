module Commands
  module GetStatusDatabase
    def self.execute
      start = Time.now

      begin
        ORM::Database.db.run('select 1')
        status = 'OK'
        error = nil
      rescue => error
        status = 'NOT_OK'
        error = error.class
      end

      duration = Time.now - start

      Models::ServiceStatus.new(status, duration, error)
    end
  end
end
