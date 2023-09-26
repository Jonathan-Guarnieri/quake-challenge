require 'net/http'
require 'pg'
require_relative '../db/connect'

class QuakeDataImporter
  KILL_LOG_REGEX = /(\d+:\d+) Kill: \d+ \d+ \d+: (.+?) killed (.+?) by (MOD_\w+)/

  def self.import
    conn = connect_to_db
    return if games_already_imported?

    games = []
    current_game = nil

    data.each_line do |line|
      case line
      when /InitGame:/
        current_game = { total_kills: 0, players: [], kills: [] }
      when /ShutdownGame:/
        games << current_game
      when /Kill:/
        current_game[:total_kills] += 1

        _, killer, victim, method = line.scan(KILL_LOG_REGEX)[0]

        current_game[:kills] << { killer: killer, victim: victim, method: method }

        current_game[:players] << killer unless current_game[:players].include?(killer) || killer == "<world>"
        current_game[:players] << victim unless current_game[:players].include?(victim)
      end
    end

    conn.prepare('insert_game', "INSERT INTO games (total_kills) VALUES ($1) RETURNING id")
    conn.prepare('insert_player', "INSERT INTO players (name) VALUES ($1) ON CONFLICT (name) DO NOTHING RETURNING id")
    conn.prepare('insert_kill', "INSERT INTO kills (game_id, killer_id, victim_id, method) VALUES ($1, $2, $3, $4)")

    games.each do |game|
      total_kills = game[:total_kills].to_i
      game_id = conn.exec_prepared('insert_game', [total_kills])[0]['id'].to_i

      game[:players].each do |player_name|
        conn.exec_prepared('insert_player', [player_name])
      end

      game[:kills].each do |kill|
        killer_id = find_player_id_by_name(kill[:killer])
        victim_id = find_player_id_by_name(kill[:victim])
        method = kill[:method]

        conn.exec_prepared('insert_kill', [game_id, killer_id, victim_id, method])
      end
    end

    conn.exec("DEALLOCATE insert_game")
    conn.exec("DEALLOCATE insert_player")
    conn.exec("DEALLOCATE insert_kill")

    conn.close
  end

  private

  def self.download_data
    url = "https://gist.githubusercontent.com/cloudwalk-tests/be1b636e58abff14088c8b5309f575d8/raw/"
    Net::HTTP.get(URI(url))
  end

  def self.data
    @data_cache ||= download_data
  end

  def self.find_player_id_by_name(name)
    return nil if name == '<world>'

    conn.exec("SELECT id FROM players WHERE name = '#{name}'")[0]['id'].to_i
  end

  def self.games_already_imported?
    games_count = conn.exec("SELECT COUNT(*) FROM games")[0]['count'].to_i
    games_count.positive?
  end

  def self.conn
    @conn ||= connect_to_db
  end
end
