module ORM
  class Database
    ENVIRONMENT = ENV['RACK_ENV']
    DB_LOG_FILE = ENV['DB_LOG_FILE']

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

      def drop_test_database
        raise 'Drop database not allowed' unless ENVIRONMENT == 'development'

        db.run('DROP DATABASE IF EXISTS postgres_test')
      end

      def create_test_database
        raise 'Create database not allowed' unless ENVIRONMENT == 'development'

        db.run('CREATE DATABASE postgres_test OWNER postgres')
      end

      private

      def connect(environment)
        config = db_config(environment)
        config.merge!(logger_config)
        Sequel.connect(config)
      end

      def db_config(environment)
        # what's difference betweem YAML.safe_load and YAML.load?
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

ORM::Database.db
