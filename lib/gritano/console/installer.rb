module Gritano
  module Console
    class Installer < Gritano::Console::Base

      def initialize(stdin = STDIN, home_dir = Etc.getpwuid.dir)
        @home_dir = home_dir
        @stdin = stdin
        super(@stdin, @home_dir)
      end

      before_each_command do
        check_git
      end
    
      add_command "help" do |argv|
        [true, Console::Installer.help]
      end

      add_command "setup:prepare" do |argv|
        Dir.mkdir(File.join(@home_dir, '.gritano')) unless File.exist?(File.join(@home_dir, '.gritano'))
        Dir.mkdir(File.join(@home_dir, '.ssh')) unless File.exist?(File.join(@home_dir, '.ssh'))
        File.open(File.join(@home_dir, '.gritano', 'database.yml'), "w") do |f|
          f.write("adapter: sqlite3\ndatabase: #{File.join(Etc.getpwuid.dir, '.gritano', 'database.db')}\n")
        end
        if File.exist?(File.join(@home_dir, '.gritano', 'database.db'))
          FileUtils.rm(File.join(@home_dir, '.gritano', 'database.db'))
        end
        return [true, "configuration has been generated"]
      end

      add_command "setup:install" do |argv|
        ActiveRecord::Base.establish_connection(
          YAML::load(File.open(File.join(@home_dir, '.gritano', 'database.yml'))))
        ActiveRecord::Migrator.migrate(
          File.join(File.dirname(__FILE__),'..', '..', '..', 'db/migrate'), 
          ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
         [true, "gritano has been installed"]
      end
    end
  end
end
