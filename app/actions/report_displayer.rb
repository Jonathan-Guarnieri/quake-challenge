require_relative '../../db/connect'

module Actions
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
