require_relative '../db/connect'

def create_test_database
  conn = PG.connect(
    host: 'db',
    dbname: 'postgres',
    user: 'my_user',
    password: 'my_secret_password'
  )

  begin
    # sleep 3
    print "Checking test database"
    # sleep 1
    print "."
    # sleep 1
    print "."
    # sleep 1
    puts "."
    # sleep 1
    conn.exec("CREATE DATABASE quake_logs_test;")
  rescue PG::DuplicateDatabase
    # sleep 3
    puts "Database quake_logs_test already exists."
    # sleep 3
  ensure
    conn.close
  end
end

create_test_database()
