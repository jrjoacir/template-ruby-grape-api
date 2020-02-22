# frozen_string_literal: true

module ORM
  class Database
    ENVIRONMENT = ENV['RACK_ENV']
    DB_LOG_FILE = ENV['DB_LOG_FILE']
    DB_CONFIG_FILE = ENV['DB_CONFIG_FILE']
    DB_MIGRATIONS_DIRECTORY = ENV['DB_MIGRATIONS_DIRECTORY']
    TIMEOUT_SECONDS = 30

    class << self
      def db
        @db ||= begin
          connect(ENVIRONMENT)
        end
      end

      def migrate(version = nil)
        Sequel.extension :migration
        Sequel::Migrator.run(db, DB_MIGRATIONS_DIRECTORY, target: version)
      end

      def test!
        db.run('select 1')
      end

      private

      def connect(environment)
        config = db_config(environment)
        config.merge!(logger_config)
        try_connect(config)
      end

      def try_connect(config)
        timeout = TIMEOUT_SECONDS
        while timeout.positive?
          begin
            return Sequel.connect(config)
          rescue StandardError => e
            timeout -= 1
            sleep(1)
            raise "Database timeout: #{e}" if timeout <= 0
          end
        end
      end

      def db_config(environment)
        config = YAML.safe_load(ERB.new(File.read(DB_CONFIG_FILE)).result)
        config[environment]
      end

      def logger_config
        File.delete(DB_LOG_FILE) if File.exist?(DB_LOG_FILE)
        { logger: Logger.new(DB_LOG_FILE) }
      end
    end
  end
end

ORM::Database.db
