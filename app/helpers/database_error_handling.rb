module Helpers
  module DatabaseErrorHandling
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def handle_errors
        yield
      rescue PG::UndefinedTable
        puts "The migrations have not been run yet. Please run them before proceeding."
        restart_app
      rescue PG::Error => e
        if table_empty?(extract_table_from_error(e.message))
          puts "The database table seems to be empty. Please import the data first."
          restart_app
        else
          raise e
        end
      end
    
      private
    
      def extract_table_from_error(error_message)
        match = error_message.match(/relation "(.*?)" does not exist/)
        match[1] if match
      end
    
      def table_empty?(table_name)
        return false unless table_name
    
        conn = connect_to_db
        count = conn.exec("SELECT COUNT(*) FROM #{table_name}")[0]['count'].to_i
        conn.close
    
        count.zero?
      end

      def restart_app
        App.start()
      end
    end
  end
end
