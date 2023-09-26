require_relative 'menu'
require_relative 'managers/migration_manager'
require_relative 'managers/data_manager'
require_relative 'reports/game_report'
require_relative 'reports/player_ranking_report'
require_relative 'reports/death_cause_report'

module CLI
  def self.start
    loop do
      system "clear"
      Menu.main_menu
      choice = gets.chomp.to_i


      case choice
      when 0
        system "clear"
        Managers::DataManager.delete_all_data
      when 1
        system "clear"
        Managers::MigrationManager.apply_migrations
      when 2
        system "clear"
        Managers::DataManager.import_data
        puts "Data has been updated."
      when 3
        system "clear"
        Reports::GameReport.display
      when 4
        system "clear"
        Reports::PlayerRankingReport.display
      when 5
        system "clear"
        Reports::DeathCauseReport.display
      when 6
        system "clear"
        puts "Exiting..."
        break
      else
        puts "Invalid choice. Please try again."
      end

      print "\n\nPUNCH THE ENTER TO CONTINUE "
      gets.chomp
      system "clear"
    end
  end
end
