require_relative 'app/helpers/database_error_handling.rb'
require_relative 'app/cli'

class App
  include Helpers::DatabaseErrorHandling

  def self.start
    handle_errors do
      CLI.start()
    end
  end
end

App.start()
