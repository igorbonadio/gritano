module Gritano
  module CLI
    def CLI.configure(&block)
      yield Config
      if Config.remote
        require File.join(File.dirname(__FILE__), "console/remote")
        Gritano::CLI::Console::Remote.start
      else
        require File.join(File.dirname(__FILE__), "console/local")
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