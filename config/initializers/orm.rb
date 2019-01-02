module ORM
  class Database
    class << self
      attr_reader :db

      def connect(environment)
        config = db_config(environment)
        config.merge!(logger_config)
        @db ||= Sequel.connect(config)
      end

      def migrate(version = nil)
        Sequel.extension :migration
        Sequel::Migrator.run(db, dir_migrations, target: version)
      end

      private

      def db_config(environment)
        # what's difference betweem YAML.safe_load and YAML.load?
        config = YAML.load(ERB.new(File.read(path_config_file)).result)
        config[environment]
      end

      def path_config_file
        'config/database.yml'
      end

      def logger_config
        file_name = "logs/#{ENV['DB_LOG_FILE']}"
        File.delete(file_name) if File.exist?(file_name)
        { logger: Logger.new(file_name) }
      end

      def dir_migrations
        'db/migrations'
      end
    end
  end
end

ORM::Database.connect(ENV['RACK_ENV'])
