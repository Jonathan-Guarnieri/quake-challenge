require_relative '../db/connect'
require_relative '../scripts/import_quake_data'

RSpec.describe QuakeDataImporter do
  before(:all) do
    conn = connect_to_db
    conn.exec("DELETE FROM kills;")
    conn.exec("DELETE FROM players;")
    conn.exec("DELETE FROM games;")
    conn.close
  end

  describe ".import" do
    it "imports data correctly" do
      described_class.import

      conn = connect_to_db

      games_count = conn.exec("SELECT COUNT(*) FROM games")[0]['count'].to_i
      expect(games_count).to be > 0

      players_count = conn.exec("SELECT COUNT(*) FROM players")[0]['count'].to_i
      expect(players_count).to be > 0

      kills_count = conn.exec("SELECT COUNT(*) FROM kills")[0]['count'].to_i
      expect(kills_count).to be > 0

      conn.close
    end
  end
end
