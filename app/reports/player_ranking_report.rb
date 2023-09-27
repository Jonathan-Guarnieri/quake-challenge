require_relative 'report'

module Reports
  class PlayerRankingReport < Report
    def self.display
      return unless ensure_data('players')

      conn = connect_to_db

      query = <<-SQL
        SELECT players.name,
          COALESCE(SUM(CASE WHEN kills.killer_id = players.id THEN 1 ELSE 0 END), 0) - 
          COALESCE(SUM(CASE WHEN kills.victim_id = players.id AND kills.killer_id IS NULL THEN 1 ELSE 0 END), 0) AS score
        FROM players
        LEFT JOIN kills ON (kills.killer_id = players.id OR (kills.victim_id = players.id AND kills.killer_id IS NULL))
        GROUP BY players.name
        ORDER BY score DESC;
      SQL

      results = conn.exec(query)

      system "clear"

      puts "\n══════════════════════════════════════════════"
      puts "🔥 PLAYERS RANKING 🔥"
      puts "══════════════════════════════════════════════"
      results.each_with_index do |row, index|
        rank = "#{index + 1}.".ljust(4)
        name = row['name'].ljust(20)
        score = "Score: #{row['score'].rjust(3)}".rjust(10)
        puts "#{rank} #{name} #{score}"
      end
      puts "══════════════════════════════════════════════"
      puts "Legends never die, they respawn! 🚀"
      puts "══════════════════════════════════════════════"

      conn.close
    end
  end
end
