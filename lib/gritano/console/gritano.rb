require "terminal-table"

module Gritano
  module Console
    class Gritano < Gritano::Console::Base
      attr_accessor :repo_path
      attr_accessor :ssh_path

      def initialize(stdin)
        @repo_path = Etc.getpwuid.dir
        @ssh_path = File.join(Etc.getpwuid.dir, '.ssh')
        @stdin = stdin
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
          executor = Executor.new(@stdin)
          executor.ssh_path = @ssh_path
          executor.repo_path = @repo_path
          executor.execute(params)
        end
      end
    end
  end
end
