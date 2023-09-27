require_relative 'menu'
require_relative 'managers/migration_manager'
require_relative 'managers/data_manager'
require_relative 'reports/game_report'
require_relative 'reports/player_ranking_report'
require_relative 'reports/death_cause_report'

module CLI
  ACTIONS = {
    1 => { manager: Managers::DataManager, action: :delete_all_data, message: "All data destroyed!" },
    2 => { manager: Managers::MigrationManager, action: :apply_migrations, message: "Migrations applied!" },
    3 => { manager: Managers::DataManager, action: :import_data, message: "Data imported!" },
    4 => { manager: Reports::GameReport, action: :display, },
    5 => { manager: Reports::PlayerRankingReport, action: :display, },
    6 => { manager: Reports::DeathCauseReport, action: :display, }
  }.freeze

  def self.start
    loop do
      display_menu_and_act
    end
  end

  def self.display_menu_and_act
    system "clear"
    Menu.main_menu
    choice = gets.chomp.to_i

    if ACTIONS.key?(choice)
      system "clear"
      puts "\n"
      ACTIONS[choice][:manager].send(ACTIONS[choice][:action])
      display_in_computer(ACTIONS[choice][:message]) if ACTIONS[choice][:message]
    elsif choice == 9
      system "clear"
      puts "Exiting..."
      exit
    else
      system "clear"
      puts "\nWrong move, warrior! Reload and choose wisely."
    end

    await_continue
  end

  def self.display_in_computer(message)
    puts "\n\n"
    puts <<~TERMINAL

  +===================================================================================+
                                                                                       
     ░█▀▀█ ░█─░█ ─█▀▀█ ░█─▄▀ ░█▀▀▀ 　 ▀▀█▀▀ ░█▀▀▀ ░█▀▀█ ░█▀▄▀█ ▀█▀ ░█▄─░█ ─█▀▀█ ░█───  
     ░█─░█ ░█─░█ ░█▄▄█ ░█▀▄─ ░█▀▀▀ 　 ─░█── ░█▀▀▀ ░█▄▄▀ ░█░█░█ ░█─ ░█░█░█ ░█▄▄█ ░█───  
     ─▀▀█▄ ─▀▄▄▀ ░█─░█ ░█─░█ ░█▄▄▄ 　 ─░█── ░█▄▄▄ ░█─░█ ░█──░█ ▄█▄ ░█──▀█ ░█─░█ ░█▄▄█  
                                                                                       
  +===================================================================================+
  |                                                                                   |
  |   #{message.center(77)}   |
  |                                                                                   |
  +===================================================================================+

  TERMINAL
  end

  def self.await_continue
    print "\n\nPUNCH THE ENTER TO CONTINUE "
    gets.chomp
    system "clear"
  end
end
