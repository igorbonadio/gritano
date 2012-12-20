require "terminal-table"

module Gritano
  module Console
    class Base

      def initialize(stdin = STDIN, home_dir = Etc.getpwuid.dir)
        @home_dir = home_dir
        @stdin = stdin
      end

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

      def self.commands=(cmds)
        @commands = cmds
      end

      def self.bin_name
        @bin_name || "gritano"
      end

      def self.bin_name=(name)
        @bin_name = name
      end

      def self.help
        msg = "  #{self.bin_name} [command]\n\n"
        msg += "  Examples:\n"
        commands.each do |command, parameters|
          msg += "  #{self.bin_name} #{command} #{parameters}\n"
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

      def check_gritano
        unless File.exist?(File.join(@home_dir, '.gritano'))
          puts "Error: First run 'gritano setup:prepare && gritano setup:install'"
          exit
        end
      end

      def check_git
        if `which git` == ""
          puts "Error: git must be installed on the local system"
          exit
        end
      end

      def before_each_command_filter
      end
    end
  end
end
