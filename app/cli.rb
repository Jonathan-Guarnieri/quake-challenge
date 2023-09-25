require_relative 'menu'
require_relative 'actions/migration_manager'
require_relative 'actions/data_manager'
require_relative 'actions/report_displayer'
require_relative 'actions/ranking_displayer'

module CLI
  def self.start
    loop do
      Menu.main_menu
      choice = gets.chomp.to_i
      puts ''

      case choice
      when 0
        Actions::DataManager.delete_all_data
      when 1
        Actions::MigrationManager.apply_migrations
      when 2
        Actions::DataManager.import_data
        puts "Data has been imported."
      when 3
        Actions::ReportDisplayer.display_report
      when 4
        Actions::RankingDisplayer.player_ranking
      when 5
        puts "Exiting..."
        break
      else
        puts "Invalid choice. Please try again."
      end
    end
  end
end
