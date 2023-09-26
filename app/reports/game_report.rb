module Reports
  class GameReport
    require_relative '../../db/connect'

    def self.display
      conn = connect_to_db

      # Retrieve list of games
      games = conn.exec("SELECT id, total_kills FROM games")

      # Loop through each game and display its report
      games.each do |game|
        game_id = game['id'].to_i
        total_kills = game['total_kills'].to_i

        # Retrieve players involved in the game (both killers and victims)
        player_result = conn.exec("SELECT DISTINCT players.name FROM kills JOIN players ON (kills.victim_id = players.id OR kills.killer_id = players.id) WHERE game_id = $1 AND players.name <> '<world>'", [game_id])
        players = player_result.map { |row| row["name"] }

        # Initialize kills hash with 0 kills for each player
        kills = Hash[players.collect { |player| [player, 0] }]

        # Populate kills from database
        kills_result = conn.exec("SELECT players.name, COUNT(kills.id) AS kill_count FROM kills JOIN players ON kills.killer_id = players.id WHERE game_id = $1 AND players.name <> '<world>' GROUP BY players.name", [game_id])
        kills_result.each do |row|
          kills[row["name"]] = row["kill_count"].to_i
        end

        # Adjust for deaths caused by <world>
        world_kills_result = conn.exec("SELECT players.name, COUNT(kills.id) AS kill_count FROM kills JOIN players ON kills.victim_id = players.id WHERE game_id = $1 AND kills.killer_id IS NULL GROUP BY players.name", [game_id])
        world_kills_result.each do |row|
          player_name = row["name"]
          kill_count = row["kill_count"].to_i
          kills[player_name] -= kill_count
        end

        # PRINTING:

        # Start of the game box
        puts "\n\n" "╔" + "═" * 48 + "╗"
        puts "║" + "⚔️⚔️⚔️ Game #{game_id} Report ⚔️⚔️⚔️".center(54) + "║"
        puts "╠" + "═" * 48 + "╣"

        # Total Kills
        puts "║ 🔥 Total Kills: #{total_kills}".ljust(48) + "║"

        # Players Involved
        puts "║ 🎮 Players Involved:".ljust(48) + "║"
        if players.any?
          players.each { |player| puts "║    - #{player}".ljust(49) + "║" }
        else
          puts "║    None".ljust(49) + "║"
        end

        # Player Kills
        puts "╟" + "─" * 48 + "╢"
        puts "║ 📊 Player Kills:".ljust(48) + "║"
        if kills.any?
          sorted_kills = kills.sort_by { |_k, v| -v }
          sorted_kills.each_with_index do |(player, kill_count), index|
            puts "║    #{(index+1).to_s.rjust(2)}. #{player.ljust(20)} : #{kill_count}".ljust(49) + "║"
          end
        else
          puts "║    No kills recorded".ljust(49) + "║"
        end

        # End of the game box
        puts "╚" + "═" * 48 + "╝"
      end

      conn.close
    end
  end
end
