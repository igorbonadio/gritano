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
      
      add_command "plugin:list" do |argv|
        msg = Terminal::Table.new do |t|
          t << ['plugin', 'installed']
          t << :separator
          Plugin.list.each do |plugin, params|
            t.add_row [plugin, params[:installed].call]
          end
        end
        return [true, msg]
      end
      
      add_command "plugin:info", "plugin_name" do |argv|
        name, = argv
        begin
          return [true, Plugin.list[name][:klass].info]
        rescue
          return [false, "There isn't a plugin called #{name}"]
        end
      end
      
      add_command "plugin:add", "plugin_name" do |argv|
        name, = argv
        begin
          Plugin.list[name][:klass].new.add
          return [true, "Plugin #{name} was added"]
        rescue
          return [false, "There isn't a plugin called #{name}"]
        end
      end
      
      add_command "plugin:rm", "plugin_name" do |argv|
        name, = argv
        begin
          Plugin.list[name][:klass].new.remove
          return [true, "Plugin #{name} was removed"]
        rescue
          return [false, "There isn't a plugin called #{name}"]
        end
      end
      
      add_command "plugin:exec", "plugin_name command" do |argv|
        name = argv[0]
        params = argv[1..-1]
        begin
          return [true, Plugin.list[name][:klass].new.exec(params)]
        rescue Exception => e
          puts e
          return [false, "There isn't a plugin called #{name}"]
        end
      end

      def method_missing(meth, *args, &block)
        params = [meth.to_s.gsub("_", ":")] + args[0]
        begin
          installer = Installer.new(@stdin, @home_dir)
          installer.execute(params)
        rescue
          executor = Executor.new(@stdin, @home_dir, @repo_path)
          executor.execute(params)
        end
      end
    end
  end
end
