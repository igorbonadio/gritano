require "terminal-table"

module Gritano
  module Console
    class Base

      def self.add_command(command, parameters = "", &block)
        define_method(command.gsub(':', '_'), &block)
        commands[command] = parameters
      end

      def self.before_each_command(&block)
        define_method(:before_each_command_filter, &block);
      end

      def self.commands
        @commands || @commands = Hash.new
      end

      def self.help
        msg = "  gritano [command]\n\n"
        msg += "  Examples:\n"
        commands.each do |command, parameters|
          msg += "  gritano #{command} #{parameters}\n"
        end
        msg += "\n  --\n  v#{File.open(File.join(File.dirname(__FILE__), '..', '..', '..', 'VERSION')).readlines.join}"
        msg
      end

      def execute_without_filters(argv)
        send(argv[0].gsub(':', '_'), argv[1..-1])
      end

      def execute(argv)
        send(:before_each_command_filter)
        execute_without_filters(argv)
      end
    end
  end
end
