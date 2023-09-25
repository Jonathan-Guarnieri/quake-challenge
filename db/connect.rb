require 'pg'

def connect_to_db
  PG.connect(host: 'db', dbname: db_name, user: 'my_user', password: 'my_secret_password')
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
