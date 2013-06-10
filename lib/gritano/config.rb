module Gritano
  module CLI
    def CLI.configure(&block)
      yield Config
      Gritano::CLI::Console.start
    end

    class Config
      def self.database_connection
        @database_configuration
      end

      def self.database_connection=(db)
        @database_configuration = db
      end
    end
  end
end