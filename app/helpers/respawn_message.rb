# helpers/respawn_message.rb
module Helpers
  module RespawnMessage
    require 'io/console'

    MESSAGES = {
      run_migrations_first: "Battlegrounds not detected. Prepare the battlefields (migrations) before the bloodshed.",
      import_data_first: 'The warzone is silent. Arm the combatants (data) to ignite the chaos.'
    }

    def self.show(message_key)
      message = MESSAGES[message_key]
      rows, columns = IO.console.winsize
      middle_row = rows / 2

      STDIN.echo = false
      STDIN.raw!

      hide_cursor

      10.downto(1) do |i|
        system "clear"
        (1..middle_row-2).each { puts "" }
        puts message.center(columns)
        puts "Respawning in #{i}...".center(columns)
        sleep 1
      end

      show_cursor

      STDIN.echo = true
      STDIN.cooked!

      restart_app
    end

    def self.hide_cursor
      print "\e[?25l"
    end
  
    def self.show_cursor
      print "\e[?25h"
    end

    def self.restart_app
      App.start()
    end
  end
end
