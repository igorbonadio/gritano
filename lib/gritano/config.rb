module Gritano
  module CLI
    def CLI.configure(&block)
      yield Config
      if Config.remote
        Gritano::CLI::Console::Remote.start
      else
        Gritano::CLI::Console::Local.start
      end
    end

    class Config
      def self.method_missing(method, *args)
        if /\=$/.match(method)
          instance_variable_set("@#{method.to_s.gsub("=", "")}", args[0])
        else
          instance_variable_get("@#{method}")
        end
      end
    end
  end
end