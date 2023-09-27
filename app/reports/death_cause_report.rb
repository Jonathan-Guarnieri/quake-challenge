require_relative 'report'

module Reports
  class DeathCauseReport < Report
    def self.display
      return unless ensure_data('kills')

      conn = connect_to_db

      games = conn.exec("SELECT id FROM games")

      system "clear"

      games.each do |game|
        game_id = game['id'].to_i
        
        query = <<-SQL
          SELECT method, COUNT(method) as death_count
          FROM kills
          WHERE game_id = $1
          GROUP BY method
          ORDER BY death_count DESC;
        SQL

        results = conn.exec(query, [game_id])

        puts "╔════════════════════════════════════════════════╗"
        puts "║ Bloodshed Summary for Game #{game_id.to_s.ljust(20)}║"
        puts "╠═════════════════════════════╦══════════════════╣"

        results.each do |row|
          cause = row['method'][0..20].ljust(27)
          count = row['death_count'].to_s.rjust(16)
          puts "║ #{cause} ║ #{count} ║"
        end
        
        puts "╚═════════════════════════════╩══════════════════╝"
        puts ""
      end

      puts "\nEnd of report. Stay sharp on the battlefield! 🔫"

      conn.close
    end
  end
end
