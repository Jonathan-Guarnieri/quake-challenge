require_relative '../db/connect'
require_relative '../scripts/import_quake_data'

RSpec.describe QuakeDataImporter do
  let(:conn) { connect_to_db }

  before(:each) do
    described_class.import
  end

  after(:each) do
    conn.exec("DELETE FROM kills;")
    conn.exec("DELETE FROM players;")
    conn.exec("DELETE FROM games;")
  end

  describe ".import" do
    it "imports the correct number of games" do
      games_count = conn.exec("SELECT COUNT(*) FROM games")[0]['count'].to_i
      expect(games_count).to eq(expected_games_count)
    end

    it "imports the correct number of players" do
      players_count = conn.exec("SELECT COUNT(*) FROM players")[0]['count'].to_i
      expect(players_count).to eq(expected_players_count)
    end

    it "imports the correct number of kills" do
      kills_count = conn.exec("SELECT COUNT(*) FROM kills")[0]['count'].to_i
      expect(kills_count).to eq(expected_kills_count)
    end

    it "imports specific players correctly" do
      player = conn.exec("SELECT name FROM players WHERE name = 'Isgalamido'")[0]
      expect(player).not_to be_nil
    end

    it "does not include <world> as a player" do
      world_player = conn.exec("SELECT COUNT(*) FROM players WHERE name = '<world>'")[0]['count'].to_i
      expect(world_player).to eq(0)
    end

    it "registers world kills correctly" do
      world_kills = conn.exec("SELECT COUNT(*) FROM kills WHERE killer_id IS NULL")[0]['count'].to_i
      expect(world_kills).to eq(expected_world_kills)
    end

    it "verifies game without kills" do
      game_with_no_kills = conn.exec("SELECT COUNT(*) FROM games WHERE total_kills = 0")[0]['count'].to_i
      expect(game_with_no_kills).to eq(expected_games_without_kills)
    end

    it "ensures total kills consistency" do
      games = conn.exec("SELECT * FROM games")
      games.each do |game|
        total_kills = game["total_kills"].to_i
        individual_kills = conn.exec("SELECT COUNT(*) FROM kills WHERE game_id = #{game["id"]}")[0]['count'].to_i
        expect(total_kills).to eq(individual_kills)
      end
    end

    it "does not duplicate data on subsequent imports" do
      initial_games_count = conn.exec("SELECT COUNT(*) FROM games")[0]['count'].to_i
      described_class.import
      second_games_count = conn.exec("SELECT COUNT(*) FROM games")[0]['count'].to_i
      expect(initial_games_count).to eq(second_games_count)
    end

    it "imports kill methods correctly" do
      mod_railgun_kills = conn.exec("SELECT COUNT(*) FROM kills WHERE method = 'MOD_RAILGUN'")[0]['count'].to_i
      expect(mod_railgun_kills).to eq(expected_mod_railgun_kills)
    end
  end

  # Add helper methods or constants:

  def expected_games_count
    20
  end

  def expected_players_count
    10
  end

  def expected_kills_count
    1058
  end

  def expected_world_kills
    232
  end

  def expected_mod_railgun_kills
    132
  end

  def expected_games_without_kills
    2
  end
end
