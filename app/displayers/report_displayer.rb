require_relative '../../db/connect'

module Displayers
  class ReportDisplayer
    def self.display_report
      conn = connect_to_db
      print "Enter the game ID for the report: "
      game_id = gets.chomp.to_i

      game_result = conn.exec("SELECT total_kills FROM games WHERE id = $1", [game_id])
      total_kills = game_result.first["total_kills"]

      player_result = conn.exec("SELECT players.name FROM kills JOIN players ON kills.player_id = players.id WHERE game_id = $1", [game_id])
      players = player_result.map { |row| row["name"] }

      kills_result = conn.exec("SELECT players.name, COUNT(kills.id) AS kill_count FROM kills JOIN players ON kills.player_id = players.id WHERE game_id = $1 GROUP BY players.name", [game_id])
      kills = {}
      kills_result.each do |row|
        kills[row["name"]] = row["kill_count"].to_i
      end

      puts "Game #{game_id} Report:"
      puts "Total Kills: #{total_kills}"
      puts "Players: #{players.join(", ")}"
      puts "Kills:"
      kills.each do |player, kill_count|
        puts "#{player}: #{kill_count}"
      end

      conn.close
    end
  end
end

# METHOD_MAP = { # isso aqui precisa ser com numero? byebug
#     '0' => 'MOD_UNKNOWN',
#     '1' => 'MOD_SHOTGUN',
#     '2' => 'MOD_GAUNTLET',
#     '3' => 'MOD_MACHINEGUN',
#     '4' => 'MOD_GRENADE',
#     '5' => 'MOD_GRENADE_SPLASH',
#     '6' => 'MOD_ROCKET',
#     '7' => 'MOD_ROCKET_SPLASH',
#     '8' => 'MOD_PLASMA',
#     '9' => 'MOD_PLASMA_SPLASH',
#     '10' => 'MOD_RAILGUN',
#     '11' => 'MOD_LIGHTNING',
#     '12' => 'MOD_BFG',
#     '13' => 'MOD_BFG_SPLASH',
#     '14' => 'MOD_WATER',
#     '15' => 'MOD_SLIME',
#     '16' => 'MOD_LAVA',
#     '17' => 'MOD_CRUSH',
#     '18' => 'MOD_TELEFRAG',
#     '19' => 'MOD_FALLING',
#     '20' => 'MOD_SUICIDE',
#     '21' => 'MOD_TARGET_LASER',
#     '22' => 'MOD_TRIGGER_HURT',
#     '23' => 'MOD_NAIL',
#     '24' => 'MOD_CHAINGUN',
#     '25' => 'MOD_PROXIMITY_MINE',
#     '26' => 'MOD_KAMIKAZE',
#     '27' => 'MOD_JUICED',
#     '28' => 'MOD_GRAPPLE'
#   }

# if kill[:killer] == "<world>"
  # current_game[:kills][victim] ||= 0
  # current_game[:kills][victim] -= 1
# else
  # current_game[:kills][killer] ||= 0
  # current_game[:kills][killer] += 1
# end
