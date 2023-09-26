require_relative 'menu'
require_relative 'managers/migration_manager'
require_relative 'managers/data_manager'
require_relative 'reports/game_report'
require_relative 'reports/ranking_report'

module CLI
  def self.start
    loop do
      Menu.main_menu
      choice = gets.chomp.to_i
      puts ''

      case choice
      when 0
        Managers::DataManager.delete_all_data
      when 1
        Managers::MigrationManager.apply_migrations
      when 2
        Managers::DataManager.import_data
        puts "Data has been updated."
      when 3
        Reports::GameReport.display
      when 4
        Reports::RankingReport.player_ranking
      when 5
        puts "Exiting..."
        break
      else
        puts "Invalid choice. Please try again."
      end
    end
  end
end
