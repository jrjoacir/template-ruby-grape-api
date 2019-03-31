# frozen_string_literal: true

module ORM
  class Database
    ENVIRONMENT = ENV['RACK_ENV']
    DB_LOG_FILE = ENV['DB_LOG_FILE']
    TIMEOUT_SECONDS = 60

    class << self
      def db
        @db ||= begin
          connect(ENVIRONMENT)
        end
      end

      def migrate(version = nil)
        Sequel.extension :migration
        Sequel::Migrator.run(db, dir_migrations, target: version)
      end

      def connect_database(time = Time.now, attempt = 1)
        ORM::Database.db
      rescue StandardError => error
        error_message = "Database is not available after #{attempt} attempts"
        error_message += ", during #{TIMEOUT_SECONDS} seconds: (#{error})"
        raise error, error_message if Time.now - time > TIMEOUT_SECONDS

        connect_database(time, attempt + 1)
      end

      private

      def connect(environment)
        config = db_config(environment)
        config.merge!(logger_config)
        Sequel.connect(config)
      end

      def db_config(environment)
        config = YAML.safe_load(ERB.new(File.read(path_config_file)).result)
        config[environment]
      end

      def path_config_file
        'config/database.yml'
      end

      def logger_config
        file_name = "logs/#{DB_LOG_FILE}"
        File.delete(file_name) if File.exist?(file_name)
        { logger: Logger.new(file_name) }
      end

      def dir_migrations
        'db/migrations'
      end
    end
  end
end

ORM::Database.connect_database
