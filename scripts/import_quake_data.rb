require 'net/http'
require 'pg'
require_relative '../db/connect'

class QuakeDataImporter
  METHOD_MAP = {
    '0' => 'MOD_UNKNOWN',
    '1' => 'MOD_SHOTGUN',
    '2' => 'MOD_GAUNTLET',
    '3' => 'MOD_MACHINEGUN',
    '4' => 'MOD_GRENADE',
    '5' => 'MOD_GRENADE_SPLASH',
    '6' => 'MOD_ROCKET',
    '7' => 'MOD_ROCKET_SPLASH',
    '8' => 'MOD_PLASMA',
    '9' => 'MOD_PLASMA_SPLASH',
    '10' => 'MOD_RAILGUN',
    '11' => 'MOD_LIGHTNING',
    '12' => 'MOD_BFG',
    '13' => 'MOD_BFG_SPLASH',
    '14' => 'MOD_WATER',
    '15' => 'MOD_SLIME',
    '16' => 'MOD_LAVA',
    '17' => 'MOD_CRUSH',
    '18' => 'MOD_TELEFRAG',
    '19' => 'MOD_FALLING',
    '20' => 'MOD_SUICIDE',
    '21' => 'MOD_TARGET_LASER',
    '22' => 'MOD_TRIGGER_HURT',
    '23' => 'MOD_NAIL',
    '24' => 'MOD_CHAINGUN',
    '25' => 'MOD_PROXIMITY_MINE',
    '26' => 'MOD_KAMIKAZE',
    '27' => 'MOD_JUICED',
    '28' => 'MOD_GRAPPLE'
  }  

  def self.download_data
    url = "https://gist.githubusercontent.com/cloudwalk-tests/be1b636e58abff14088c8b5309f575d8/raw/"
    Net::HTTP.get(URI(url))
  end

  def self.import
    data = download_data
    games = []
    current_game = nil
    method_name = ''
  
    data.each_line do |line|
      case line
      when /InitGame/
        current_game = { total_kills: 0, players: [], kills: {} }
      when /ShutdownGame/
        games << current_game if current_game
        current_game = nil
      when /Kill:/
        current_game[:total_kills] += 1
      
        _, killer, victim, method = line.split
        method_name = METHOD_MAP[method] || 'UNKNOWN'
        killer_name = killer.split('<').last.split('>').first
        victim_name = victim.split('<').last.split('>').first
      
        current_game[:kills][killer_name] ||= 0
        current_game[:kills][killer_name] += 1 unless killer_name == "<world>"
        current_game[:kills][victim_name] ||= 0
        current_game[:kills][victim_name] -= 1 if killer_name == "<world>"
      
        current_game[:players] << killer_name unless current_game[:players].include?(killer_name) || killer_name == "<world>"
        current_game[:players] << victim_name unless current_game[:players].include?(victim_name) || victim_name == "<world>"
      end
    end

    conn = connect_to_db

    conn.prepare('insert_game', "INSERT INTO games (total_kills) VALUES ($1) RETURNING id")
    conn.prepare('insert_player', "INSERT INTO players (name) VALUES ($1) ON CONFLICT (name) DO NOTHING RETURNING id")
    conn.prepare('insert_kill', "INSERT INTO kills (game_id, killer_id, victim_id, method) VALUES ($1, $2, $3, $4)")

    games.each do |game|
      game_id = conn.exec_prepared('insert_game', [game[:total_kills]])[0]['id'].to_i

      game[:players].each do |player_name|
        conn.exec_prepared('insert_player', [player_name])
      end

      game[:kills].each do |player_name, kills_count|
        player_id = conn.exec("SELECT id FROM players WHERE name = '#{player_name}'")[0]['id'].to_i
        kills_count.times do
          conn.exec_prepared('insert_kill', [game_id, player_id, method_name])
        end
      end      
    end

    conn.exec("DEALLOCATE insert_game")
    conn.exec("DEALLOCATE insert_player")
    conn.exec("DEALLOCATE insert_kill")

    conn.close
  end
end
