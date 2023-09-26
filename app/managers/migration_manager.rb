require_relative '../../db/connect'

module Actions
  class MigrationManager
    TABLES = ['games', 'players', 'kills'].freeze

    def self.apply_migrations
      puts "Applying migrations..."

      if migrations_up_to_date?
        puts "Migrations are already up-to-date"
      else
        load 'db/run_migrations.rb'
        puts "Migrations applied successfully!"
      end
    end

    private

    def self.migrations_up_to_date?
      conn = connect_to_db

      missing_tables = TABLES.select do |table|
        result = conn.exec("SELECT to_regclass('#{table}');")
        result[0]['to_regclass'].nil?
      end

      conn.close

      missing_tables.empty?
    end
  end
end
