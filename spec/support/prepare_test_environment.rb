require_relative '../../db/connect'

def create_test_database
  conn = PG.connect(
    host: 'db',
    dbname: 'postgres',
    user: 'my_user',
    password: 'my_secret_password'
  )

  begin
    puts "Creating test database..."
    conn.exec("CREATE DATABASE quake_logs_test;")
  rescue PG::DuplicateDatabase
    puts "Database quake_logs_test already exists."
  ensure
    conn.close
  end
end

create_test_database()
