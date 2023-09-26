require_relative 'menu'
require_relative 'managers/migration_manager'
require_relative 'managers/data_manager'
require_relative 'displayers/report_displayer'
require_relative 'displayers/ranking_displayer'

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
        puts "Data has been imported."
      when 3
        Displayers::ReportDisplayer.display_report
      when 4
        Displayers::RankingDisplayer.player_ranking
      when 5
        puts "Exiting..."
        break
      else
        puts "Invalid choice. Please try again."
      end
    end
  end
end
