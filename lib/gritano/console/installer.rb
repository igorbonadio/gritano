module Gritano
  module Console
    class Installer < Gritano::Console::Base

      def initialize(stdin = STDIN, home_dir = Etc.getpwuid.dir)
        @home_dir = home_dir
        @stdin = stdin
        @ssh_path = File.join(@home_dir, '.ssh')
        super(@stdin, @home_dir)
      end

      before_each_command do
        check_git
      end

      def create_gritano_dirs
        Dir.mkdir(File.join(@home_dir, '.gritano')) unless File.exist?(File.join(@home_dir, '.gritano'))
        Dir.mkdir(File.join(@home_dir, '.ssh')) unless File.exist?(File.join(@home_dir, '.ssh'))
      end
      
      def create_sqlite_config
        File.open(File.join(@home_dir, '.gritano', 'database.yml'), "w") do |f|
          f.write("adapter: sqlite3\ndatabase: #{File.join(Etc.getpwuid.dir, '.gritano', 'database.db')}\n")
        end
        if File.exist?(File.join(@home_dir, '.gritano', 'database.db'))
          FileUtils.rm(File.join(@home_dir, '.gritano', 'database.db'))
        end
      end
      
      add_command "setup:prepare" do |argv|
        create_gritano_dirs
        create_sqlite_config
        return [true, "configuration has been generated"]
      end

      def create_database
        ActiveRecord::Base.establish_connection(
          YAML::load(File.open(File.join(@home_dir, '.gritano', 'database.yml'))))
        ActiveRecord::Migrator.migrate(
          File.join(File.dirname(__FILE__),'..', '..', '..', 'db/migrate'), 
          ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
      end
      
      def create_authorization_keys
        File.open(File.join(@ssh_path, 'authorized_keys'), 'w').write(Key.authorized_keys)
      end
      
      add_command "setup:install" do |argv|
        create_database
        create_authorization_keys
        [true, "gritano has been installed"]
      end
    end
  end
end
