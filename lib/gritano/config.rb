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

      def self.database_connection=(value)
        @database_configuration = value
      end

      def self.repository_path
        @repository_path
      end

      def self.repository_path=(value)
        @repository_path = value
      end
    end
  end
end