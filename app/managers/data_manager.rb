require_relative '../../db/migrations/001_create_tables.rb'
require_relative '../importers/quake_data_importer.rb'
require 'pg'

module Actions
  class DataManager
    def self.import_data
      puts "Downloading and importing Quake data..."
      QuakeDataImporter.import
    end

    def self.delete_all_data
      puts "Dropping all tables from the database..."

      begin
        down()
        puts "All data has been deleted."
      rescue PG::Error => e
        puts "Error while deleting data: #{e.message}"
      end
    end
  end
end
