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
      puts " | 1. Obliterate All Data                 (Drop All Data)       |"
      puts " | 2. Prepare the Battlefield             (Database Migrations) |"
      puts " | 3. Arm the Soldiers                    (Import Data)         |"
      puts " | 4. Chronicles of Carnage               (Report by Match)     |"
      puts " | 5. Legends of the Arena                (Player Ranking)      |"
      puts " | 6. (PLUS) Instruments of Destruction   (Death Causes)        |"
      puts " |                                                              |"
      puts " | 9. Return to Sanctuary                 (Exit)                |"
      puts " ✦ ------------------------------------------------------------ ✦"

      print "\n\nYour move, warrior: "
    end
  end
end
