module Reports
  class Report
    require_relative '../../db/connect'

    def self.has_data?(table_name)
      conn = connect_to_db
      result = conn.exec("SELECT EXISTS (SELECT 1 FROM #{table_name} LIMIT 1)")
      result.first["exists"] == "t"
    end

    def self.prompt_user_for_data
      puts "No data available. Consider importing data for a detailed report."
    end

    def self.ensure_data(table_name)
      unless has_data?(table_name)
        prompt_user_for_data
        return false
      end
      true
    end
  end
end
