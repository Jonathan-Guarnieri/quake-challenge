require_relative '../../db/migrations/001_create_tables.rb'
require_relative '../../scripts/import_quake_data'
require 'pg'

module Actions
  class DataManager
    def self.import_data
      puts "Downloading and importing Quake data..."
      QuakeDataImporter.import
    end

    def self.delete_all_data
      # sleep(1)
      print "Dropping all tables from the database"
      # sleep(1)
      print '.'
      # sleep(1)
      print '.'
      # sleep(1)
      puts '.'
      # sleep(1)

      begin
        down()
        puts "All data has been deleted."
        # sleep(2)
      rescue PG::Error => e
        puts "Error while deleting data: #{e.message}"
      end
    end
  end
end
