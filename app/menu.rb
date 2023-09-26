module CLI
  class Menu
    def self.main_menu
      puts ' '
      puts "---------------------"
      puts "Quake Log Parser CLI"
      puts "---------------------"
      puts "0. Drop tables and delete all data"
      puts "1. Run database migrations"
      puts "2. Import data"
      puts "3. Display Report by Match"
      puts "4. Display Player Ranking"
      puts "5. Exit"
      print "Enter your choice: "
    end
  end
end
