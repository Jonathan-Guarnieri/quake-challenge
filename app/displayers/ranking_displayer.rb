require_relative '../../db/connect'

module Actions
  class RankingDisplayer
    def self.player_ranking
      conn = connect_to_db

      ranking_result = conn.exec("SELECT players.name, COUNT(kills.id) AS kill_count FROM kills JOIN players ON kills.player_id = players.id GROUP BY players.name ORDER BY kill_count DESC")
      
      puts "Player Ranking:"
      ranking_result.each do |row|
        puts "#{row["name"]}: #{row["kill_count"]}"
      end

      conn.close
    end
  end
end
