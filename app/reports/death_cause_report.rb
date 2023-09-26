require_relative 'report'

module Reports
  class DeathCauseReport < Report
    def self.display
      return unless ensure_data('kills')

      conn = connect_to_db

      games = conn.exec("SELECT id FROM games")

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

        puts "\n🎮🎮 Game #{game_id} Death Causes 🎮🎮"
        puts "================================"
        results.each do |row|
          puts "#{row['method'].ljust(20)} Deaths: #{row['death_count']}"
        end
        puts "================================"
      end

      conn.close
    end
  end
end
