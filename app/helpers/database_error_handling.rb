module Helpers
  module DatabaseErrorHandling
    require_relative 'respawn_message'

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def handle_errors
        yield
      rescue PG::UndefinedTable
        Helpers::RespawnMessage.show(:run_migrations_first)
      end
    end
  end
end
