module Gritano
  module CLI
    def CLI.configure(&block)
      Config.database_connection = File.join(Etc.getpwuid.dir, '.gritano/database.yml')
      Config.repository_path = File.join(Etc.getpwuid.dir)
      Config.remote_ssh_prefix = 'ssh git@server.com'
      yield Config
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