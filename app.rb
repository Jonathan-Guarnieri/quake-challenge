require_relative 'app/concerns/database_error_handling.rb'
require_relative 'app/cli'

class App
  include DatabaseErrorHandling

  def self.start
    handle_errors do
      CLI.start()
    end
  end
end

App.start()
