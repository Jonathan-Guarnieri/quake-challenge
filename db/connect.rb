require 'pg'

def connect_to_db
  begin
    PG.connect(host: 'db', dbname: db_name, user: 'my_user', password: 'my_secret_password')
  rescue PG::ConnectionBad => e
    if e.message.include?("database \"#{db_name}\" does not exist")
      create_database(db_name)
      retry
    else
      raise e
    end
  end
end

def create_database(name)
  conn = PG.connect(host: 'db', user: 'my_user', password: 'my_secret_password')
  conn.exec("CREATE DATABASE #{name};")
  conn.close
end

def db_name
  case ENV['APP_ENV']
  when 'test'
    'quake_logs_test'
  when 'production'
    'quake_logs'
  else
    raise 'Please set an enviroment first'
  end
end
