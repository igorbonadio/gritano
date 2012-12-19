module Gritano
  module Console
    class Gritano < Gritano::Console::Base

      def initialize(stdin = STDIN, home_dir = Etc.getpwuid.dir, repo_path = Etc.getpwuid.dir)
        @stdin = stdin
        @home_dir = home_dir
        @repo_path = repo_path
        @ssh_path = File.join(@home_dir, '.ssh')
        super(@stdin, @home_dir)
      end

      add_command "help" do |argv|
        Gritano.commands = Gritano.commands.merge(Installer.commands).merge(Executor.commands)
        [true, Gritano.help]
      end

      add_command "version" do |argv|
        version = "v#{File.open(File.join(File.dirname(__FILE__), '..', '..', '..', 'VERSION')).readlines.join}"
        [true, version]
      end

      def method_missing(meth, *args, &block)
        params = [meth.to_s.gsub("_", ":")] + args[0]
        begin
          installer = Installer.new
          installer.execute(params)
        rescue
          executor = Executor.new(@stdin, @home_dir, @repo_path)
          if @desable_filters
            executor.execute_without_filters(params)
          else
            executor.execute(params)
          end
        end
      end

      def desable_filters
        @desable_filters = true
      end
    end
  end
end
