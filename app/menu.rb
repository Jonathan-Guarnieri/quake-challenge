module CLI
  class Menu
    def self.main_menu
      puts "\n\n"

      puts "░░░░░██╗░█████╗░███╗░░██╗░█████╗░████████╗██╗░░██╗░█████╗░███╗░░██╗"
      puts "░░░░░██║██╔══██╗████╗░██║██╔══██╗╚══██╔══╝██║░░██║██╔══██╗████╗░██║"
      puts "░░░░░██║██║░░██║██╔██╗██║███████║░░░██║░░░███████║███████║██╔██╗██║"
      puts "██╗░░██║██║░░██║██║╚████║██╔══██║░░░██║░░░██╔══██║██╔══██║██║╚████║"
      puts "╚█████╔╝╚█████╔╝██║░╚███║██║░░██║░░░██║░░░██║░░██║██║░░██║██║░╚███║"
      puts "░╚════╝░░╚════╝░╚═╝░░╚══╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝"
      puts ""
      puts "░██████╗░██╗░░░██╗░█████╗░██████╗░███╗░░██╗██╗███████╗██████╗░██╗"
      puts "██╔════╝░██║░░░██║██╔══██╗██╔══██╗████╗░██║██║██╔════╝██╔══██╗██║"
      puts "██║░░██╗░██║░░░██║███████║██████╔╝██╔██╗██║██║█████╗░░██████╔╝██║"
      puts "██║░░╚██╗██║░░░██║██╔══██║██╔══██╗██║╚████║██║██╔══╝░░██╔══██╗██║"
      puts "╚██████╔╝╚██████╔╝██║░░██║██║░░██║██║░╚███║██║███████╗██║░░██║██║"
      puts "░╚═════╝░░╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═╝╚══════╝╚═╝░░╚═╝╚═╝"
      puts ""
      puts "                     💀 Quake Log Analyzer 💀               "

      puts "\n\n"

      puts " ✦ ------------------------------------------------------------ ✦"
      puts " | 0. Obliterate All Data                 (Drop All Data )      |"
      puts " | 1. Prepare the Battlefield             (Database Migrations) |"
      puts " | 2. Arm the Soldiers                    (Import Data)         |"
      puts " | 3. Chronicles of Carnage               (Report by Match)     |"
      puts " | 4. Legends of the Arena                (Player Ranking)      |"
      puts " | 5. (PLUS) Instruments of Destruction   (Death Causes)        |"
      puts " |                                                              |"
      puts " | 6. Return to Sanctuary                 (Exit)                |"
      puts " ✦ ------------------------------------------------------------ ✦"

      print "\n\nYour move, warrior: "
    end
  end
end
