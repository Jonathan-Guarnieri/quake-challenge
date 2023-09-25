require_relative '../connect'

def up
  conn = connect_to_db

  conn.exec <<-SQL
    CREATE TABLE games (
      id SERIAL PRIMARY KEY,
      total_kills INT NOT NULL
    );
  SQL

  conn.exec <<-SQL
    CREATE TABLE players (
      id SERIAL PRIMARY KEY,
      name TEXT UNIQUE NOT NULL
    );
  SQL

  conn.exec <<-SQL
    CREATE TABLE kills (
      id SERIAL PRIMARY KEY,
      game_id INT NOT NULL REFERENCES games(id),
      killer_id INT REFERENCES players(id),
      victim_id INT REFERENCES players(id),
      method TEXT NOT NULL
    );
  SQL

  conn.close
end

def down
  conn = connect_to_db

  conn.exec("SET client_min_messages TO WARNING;")
  conn.exec("DROP TABLE IF EXISTS kills")
  conn.exec("DROP TABLE IF EXISTS players")
  conn.exec("DROP TABLE IF EXISTS games")

  conn.close
end
